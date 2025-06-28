import 'package:flutter/material.dart';
import 'package:multi/data/models/items_model.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/router_names.dart';
import '../../../widgets/custom_images.dart';

class ItemGridView extends StatelessWidget {
  const ItemGridView({super.key, required this.item});

  final StoreItemsModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final store = item.store;
    final price = _getItemPrice();
    final imageUrl = '${AppConstants.itemsPath}${item.item.thumbnail}';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteNames.itemDetailScreen,
        arguments: item,
      ),
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CustomImage(
                path: imageUrl,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Name
                  Text(
                    item.item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Store Name + Verified
                  if (store != null)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.verified, size: 16, color: theme.primaryColor),
                      ],
                    ),
                  const SizedBox(height: 6),

                  // Price
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Location
                  if (store?.address != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            store!.address!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getItemPrice() {
    double price = item.price?.toDouble() ?? 0.0;
    if (item.storeItemVariation?.isNotEmpty == true) {
      price += item.storeItemVariation!.first.price ?? 0.0;
    }
    return price;
  }
}
