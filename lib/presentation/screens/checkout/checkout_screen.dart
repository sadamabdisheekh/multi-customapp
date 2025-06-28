import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/order_cubit.dart';
import 'package:multi/logic/cubit/payment_method_cubit.dart';
import 'package:multi/logic/utilits/utility.dart';
import 'package:multi/presentation/widgets/capitalized_word.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';

import '../../../constants/language_string.dart';
import 'widgets/checkout_bottombar_widget.dart';
import 'widgets/checkout_single_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.cartItem});

  final List<CartResponseModel> cartItem;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextStyle headerStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  int? selectedMethodIndex;

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodCubit>().getPaymentMethods();
  }

  Future<void> _submitOrder() async {
    final selectedPayment = context.read<PaymentMethodCubit>().selectedPayment;
    if (selectedPayment == null) {
      Utils.showSnackBar(context, 'Please select a payment method.');
      return;
    }

    final body = {"paymentMethodId": selectedPayment.id};
    await context.read<OrderCubit>().createOrder(body);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        Utils.closeDialog(context);
        if (state is OrderLoadingState) {
          Utils.loadingDialog(context);
        } else if (state is OrderErrorState) {
          Utils.showSnackBar(context, state.error.message);
        } else if (state is OrderLoadedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.orderSuccessScreen, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          elevation: 1,
        ),
        body: PageRefresh(
          onRefresh: () async {
            context.read<PaymentMethodCubit>().getPaymentMethods();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              _buildCartList(),
              SliverToBoxAdapter(child: _buildPaymentMethods(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
        bottomNavigationBar: CheckoutBottomBarWidget(onPressed: _submitOrder),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined,
              color: Theme.of(context).primaryColor),
          const SizedBox(width: 10),
          Text(
            "${widget.cartItem.length} ${Language.items.capitalizeByWord()}",
            style: headerStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CheckoutSingleItem(item: widget.cartItem[index]);
          },
          childCount: widget.cartItem.length,
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Language.paymentMethods.capitalizeByWord(), style: headerStyle),
          const SizedBox(height: 10),
          BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
            builder: (context, state) {
              if (state is PaymentMethodLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PaymentMethodLoadedState) {
                final methods = state.paymentMethods;
                if (methods.isEmpty) {
                  return Text(
                    Language.noPaymentMethods.capitalizeByWord(),
                    style: const TextStyle(fontSize: 14),
                  );
                }

                return Wrap(
                  spacing: 10,
                  children: List.generate(methods.length, (index) {
                    final method = methods[index];
                    final isSelected = selectedMethodIndex == index;
                    return ChoiceChip(
                      label: Text(method.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedMethodIndex = selected ? index : null;
                        });
                        context.read<PaymentMethodCubit>().selectedPayment =
                            selected ? method : null;
                      },
                      selectedColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    );
                  }),
                );
              } else if (state is PaymentMethodErrorState) {
                return Text(state.error.message,
                    style: const TextStyle(color: Colors.red));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
