import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';

import '../../../../constants/colors.dart';
import '../../../../logic/utility.dart';
import '../../../widgets/custom_images.dart';
import 'package:auto_size_text/auto_size_text.dart';


class AddToCartComponent extends StatefulWidget {
  const AddToCartComponent({super.key, required this.cartProduct});

  final CartResponseModel cartProduct;

  @override
  State<AddToCartComponent> createState() => _AddToCartComponentState();
}

class _AddToCartComponentState extends State<AddToCartComponent> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    const double height = 120;
    int value = widget.cartProduct.quantity;
    return Container(
      height: height,
      margin: Utils.symmetric(v: 6.0, h: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: Utils.borderRadius(r: 12.0),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0.0, 0.0),
              spreadRadius: 0.0,
              blurRadius: 0.0,
              // color: whiteColor
              color: const Color(0xFF000000).withOpacity(0.4)),
        ],
      ),
      child: Row(
        children: [
           SizedBox(
            height: height - 2,
            width: width / 2.7,
            child: ClipRRect(
              borderRadius: Utils.borderRadius(r: 6.0),
              child: InkWell(
                onTap: () {
              
                },
                child: CustomImage(
                  path: AppConstants.itemsPath + widget.cartProduct.storeItem.item.thumbnail!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                      child: AutoSizeText(widget.cartProduct.storeItem.item.name,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          maxFontSize: 14,
                          minFontSize: 11,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<CartCubit>().removeCartItem(widget.cartProduct.storeItem.id);
                      },
                      child: Padding(
                          padding: Utils.only(right: 10.0),
                          child: const Icon(Icons.clear_sharp,
                              size: 20.0, color: redColor),
                        ),
                    ),
                    ],
                  ),
                  Text(
                    '\$${widget.cartProduct.price}',
                    style: const TextStyle(
                        color: redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                  Row(
                      children: [
                        InkWell(
                          onTap: 
                            widget.cartProduct.quantity > 1 ? () async {
                              
                              final result = await context.read<CartCubit>().decrementquantity(widget.cartProduct.storeItem.id);
                              result.fold(
                                (failure) {
                                  // setState(() {});
                                  Utils.errorSnackBar(context, failure.message);
                                },
                                (success) {
                                  // widget.onChange(widget.product.id);
                                  // Utils.showSnackBar(context, success);
                                  Future.microtask(() => context
                                      .read<CartCubit>()
                                      .getCartItems());
                                  // value--;
                                  // setState(() {
                                  //
                                  // });
                                },
                              );
                            } : null,
                          
                          child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Theme.of(context).primaryColor,
                          child:  Icon(Icons.remove, color: Theme.of(context).cardColor),
                                                ),
                        ),
                       Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                              
                              final result = await context.read<CartCubit>().incrementquantity(widget.cartProduct.storeItem.id);
                              result.fold(
                                (failure) {
                                  // setState(() {});
                                  Utils.errorSnackBar(context, failure.message);
                                },
                                (success) {
                                  // widget.onChange(widget.product.id);
                                  // Utils.showSnackBar(context, success);
                                  Future.microtask(() => context
                                      .read<CartCubit>()
                                      .getCartItems());
                                  // value--;
                                  // setState(() {
                                  //
                                  // });
                                },
                              );
                            },
                      child: CircleAvatar(
                          radius: 12,
                            backgroundColor: Theme.of(context).primaryColor,
                          child:  Icon(Icons.add, color: Theme.of(context).cardColor),
                        ),
                    ),
                      ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
