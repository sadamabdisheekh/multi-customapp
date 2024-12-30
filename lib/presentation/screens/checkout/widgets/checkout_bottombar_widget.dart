import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/presentation/widgets/primary_button.dart';

class CheckoutBottomBarWidget extends StatelessWidget {
  const CheckoutBottomBarWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final total = context.read<CartCubit>().total;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Total: $total',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Expanded(
            child: PrimaryButton(
              text: 'Place Order', 
              onPressed: onPressed
            ),
          )
        ],
      ),
    );
  }
}
