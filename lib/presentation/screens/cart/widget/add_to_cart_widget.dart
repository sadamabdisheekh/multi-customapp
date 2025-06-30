import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../../logic/utilits/utility.dart';
import '../../../widgets/custom_images.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddToCartComponent extends StatelessWidget {
  const AddToCartComponent({super.key, required this.cartProduct});

  final CartResponseModel cartProduct;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmall = width < 400;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Thumbnail with clipped corners
         ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomImage(
              width: isSmall ? 100 : 120,
              height: isSmall ? 80 : 100,
              path: AppConstants.itemsPath +
                  (cartProduct.storeItem.item.thumbnail),
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),
          /// Item info and controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Remove button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        cartProduct.storeItem.item.name,
                        maxLines: 2,
                        minFontSize: 12,
                        maxFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartCubit>()
                            .removeCartItem(cartProduct.storeItem.id);
                      },
                      child: const Icon(Icons.close, color: redColor, size: 20),
                    ),
                  ],
                ),

                /// Variation (if any)
                if (cartProduct.storeItem.item.hasVariations &&
                    cartProduct.variation != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      cartProduct.variation!.attributes
                          .map((e) => '${e.name}: ${e.value}')
                          .join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),

                /// Price
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '\$${cartProduct.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: redColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                /// Quantity controls
                Row(
                  children: [
                    _qtyButton(
                      context: context,
                      icon: Icons.remove,
                      onTap: cartProduct.quantity > 1
                          ? () async {
                              final result = await context
                                  .read<CartCubit>()
                                  .decrementquantity(cartProduct.storeItem.id);
                              result.fold(
                                (failure) => Utils.errorSnackBar(
                                    context, failure.message),
                                (_) =>
                                    context.read<CartCubit>().getCartItems(),
                              );
                            }
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        cartProduct.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _qtyButton(
                      context: context,
                      icon: Icons.add,
                      onTap: () async {
                        final result = await context
                            .read<CartCubit>()
                            .incrementquantity(cartProduct.storeItem.id);
                        result.fold(
                          (failure) =>
                              Utils.errorSnackBar(context, failure.message),
                          (_) => context.read<CartCubit>().getCartItems(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Quantity Button
  Widget _qtyButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: onTap != null
            ? Theme.of(context).primaryColor
            : Colors.grey.withOpacity(0.4),
        child: Icon(
          icon,
          size: 16,
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
