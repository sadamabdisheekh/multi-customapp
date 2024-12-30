import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/utility.dart';
import 'package:multi/presentation/widgets/loading_widget.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';
import '../../../data/models/cart/cart_response_model.dart';
import 'widget/add_to_cart_widget.dart';
import 'widget/bottom_bar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double height = 120;

  List<CartResponseModel>? cartResponseModel;

  @override
  void initState() {
    super.initState();
    loadCart();
     context.read<CartCubit>().getCartItems();
    cartResponseModel = context.read<CartCubit>().cartResponseModel;
  }

  loadCart() {
    Future.microtask(() => context.read<CartCubit>().getCartItems());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: PageRefresh(
        onRefresh: () async {
          context.read<CartCubit>().getCartItems();
        },
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartStateDecIncrementLoading) {
              Utils.loadingDialog(context);
            } 
            if (state is CartStateDecIncError) {
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, state.message);
            }
            if (state is CartStateRemove) {
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, state.message);
            }
            if (state is CartDecIncState) {
              Utils.closeDialog(context);
              Utils.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CartStateLoading) {
              return const LoadingWidget();
            } else if (state is CartStateError) {
              return Center(child: Text(state.message));
            } else if (state is CartStateLoaded) {
              return _LoadedWidget(cartResponseModel: state.cartResponse);
            }
            return  _LoadedWidget(cartResponseModel:  cartResponseModel ?? []);
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final total = context.read<CartCubit>().total;
          return total > 0 ? BottomBarWidget(
            total: context.read<CartCubit>().total,
          ): const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({required this.cartResponseModel});

  final List<CartResponseModel> cartResponseModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart_rounded,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 10),
                    Text(
                      _getText(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return AddToCartComponent(
                    cartProduct: cartResponseModel[index]);
              }, childCount: cartResponseModel.length),
            )
          ],
        );
      },
    );
  }

  String _getText() {
    final length = cartResponseModel.length;
    if (length > 1) {
      return '$length Items';
    } else {
      return '$length Item';
    }
  }
}
