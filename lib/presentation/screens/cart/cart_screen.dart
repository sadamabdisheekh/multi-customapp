import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/utilits/utility.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CartCubit>().getCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: PageRefresh(
        onRefresh: () async {
          context.read<CartCubit>().getCartItems();
        },
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartStateDecIncrementLoading) {
              Utils.loadingDialog(context,message: 'loading');
            } else if (state is CartStateDecIncError) {
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, state.message);
            } else if (state is CartStateRemove) {
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, state.message);
            } else if (state is CartDecIncState) {
              Utils.closeDialog(context);
              Utils.showSnackBar(context, state.message);
            }

          },
          builder: (context, state) {
            if (state is CartStateLoading) {
              return const LoadingWidget();
            } else if (state is CartStateError) {
              return Center(child: Text(state.message));
            } else {
              final cartItems =
                  state is CartStateLoaded ? state.cartResponse : context.read<CartCubit>().cartResponseModel ?? [];

              if (cartItems.isEmpty) {
                return const Center(child: Text("Your cart is empty."));
              }

              return _CartList(cartItems: cartItems);
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final total = context.read<CartCubit>().total;
          return total > 0
              ? BottomBarWidget(total: total)
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({required this.cartItems});

  final List<CartResponseModel> cartItems;

  @override
  Widget build(BuildContext context) {
    final length = cartItems.length;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Icon(Icons.shopping_cart_outlined,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 10),
                Text(
                  "$length ${length > 1 ? "Items" : "Item"}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddToCartComponent(cartProduct: cartItems[index]),
                );
              },
              childCount: cartItems.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}
