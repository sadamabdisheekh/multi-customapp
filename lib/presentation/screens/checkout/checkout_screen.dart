import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/order_cubit.dart';
import 'package:multi/logic/utility.dart';
import 'package:multi/presentation/widgets/capitalized_word.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';

import '../../../constants/language_string.dart';
import '../../../logic/cubit/payment_method_cubit.dart';
import 'widgets/checkout_bottombar_widget.dart';
import 'widgets/checkout_single_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.cartItem});

  final List<CartResponseModel> cartItem;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodCubit>().getPaymentMethods();
  }

  _onPressed() async {
    final selectedPayment = context.read<PaymentMethodCubit>().selectedPayment;
    if (selectedPayment == null) {
      Utils.showSnackBar(context, 'please select payment');
      return;
    }

    final body = {"paymentMethodId": selectedPayment.id};

    await context.read<OrderCubit>().createOrder(body);
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderLoadingState) {
          Utils.loadingDialog(context);
        }else {
          Utils.closeDialog(context);
          if (state is OrderErrorState) {
            Utils.showSnackBar(context, state.error.message);
          } else if (state is OrderLoadedState) {
            Navigator.pushNamedAndRemoveUntil(context, RouteNames.orderSuccessScreen, (route) => false);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: PageRefresh(
          onRefresh: () async {
            context.read<PaymentMethodCubit>().getPaymentMethods();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildItemNumber(context)),
              _buildProductList(),
              _buildPaymentMethodList()
            ],
          ),
        ),
        bottomNavigationBar: CheckoutBottomBarWidget(onPressed: _onPressed),
      ),
    );
  }

  Widget _buildItemNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
      child: Row(
        children: [
          Icon(Icons.shopping_cart_rounded,
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

  Widget _buildProductList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CheckoutSingleItem(item: widget.cartItem[index]);
          },
          childCount: widget.cartItem.length,
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Language.paymentMethods.capitalizeByWord(),
              style: headerStyle,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50, // Adjust height as needed
              child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                builder: (context, state) {
                  if (state is PaymentMethodLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PaymentMethodLoadedState) {
                    final methods =
                        state.paymentMethods; // Assuming it's a list
                    if (methods.isEmpty) {
                      return Center(
                        child: Text(
                          Language.noPaymentMethods.capitalizeByWord(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }

                    int? selectedMethodIndex; // Tracks the selected chip
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: methods.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ChoiceChip(
                                label: Text(
                                  methods[index]
                                      .name, // Assuming the model has a `name` property
                                  style: const TextStyle(fontSize: 14),
                                ),
                                selected: selectedMethodIndex == index,
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedMethodIndex =
                                        isSelected ? index : null;
                                  });

                                  context
                                          .read<PaymentMethodCubit>()
                                          .selectedPayment =
                                      isSelected ? methods[index] : null;
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is PaymentMethodErrorState) {
                    return Center(
                      child: Text(
                        state.error.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: Text(''));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
