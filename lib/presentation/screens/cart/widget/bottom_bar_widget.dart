import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/presentation/widgets/capitalized_word.dart';

import '../../../../constants/language_string.dart';
import '../../../widgets/primary_button.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    super.key, required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
     width: MediaQuery.of(context).size.width,
       decoration:  BoxDecoration(
         color: Theme.of(context).cardColor,
         borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(
               Language.orderAmount.capitalizeByWord(),
               style:
                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
             ),
             Text(  
                 '\$$total',
                   style: const TextStyle(
                       fontSize: 16, fontWeight: FontWeight.w600),
                 )
           ],
         ),
         const SizedBox(height: 5),
         SizedBox(
           height: 50,
           child: PrimaryButton(
             text: Language.checkout.capitalizeByWord(),
             onPressed: () {
              final cartItems = context.read<CartCubit>().cartResponseModel;
             Navigator.pushNamed(context, RouteNames.checkoutScreen,arguments: cartItems);
             },
           ),
         )
       ]
     ),
    );
  }
}