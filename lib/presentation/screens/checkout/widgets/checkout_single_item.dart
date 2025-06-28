import 'package:flutter/material.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import '../../../widgets/custom_images.dart';

class CheckoutSingleItem extends StatelessWidget {
  const CheckoutSingleItem({super.key, required this.item});

  final CartResponseModel item;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isSmall = width < 400;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: isSmall ? 70 : 90,
              height: isSmall ? 70 : 90,
              child: CustomImage(
                path: AppConstants.itemsPath +
                    (item.storeItem.item.thumbnail),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item name
                Text(
                  item.storeItem.item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Variations (if any)
                if (item.storeItem.item.hasVariations &&
                    item.variation !=
                        null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.variation!.attributes
                          .map((e) =>
                              '${e.name}: ${e.value}')
                          .join(' • '),
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),

                const SizedBox(height: 6),

                // Price + Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'x ${item.quantity}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
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
}
