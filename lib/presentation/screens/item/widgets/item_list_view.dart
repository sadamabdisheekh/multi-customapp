import 'package:flutter/material.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/presentation/widgets/custom_images.dart';
import '../../../../data/models/items_model.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({super.key, required this.itemInfo});

  final StoreItemsModel itemInfo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final store = itemInfo.store;
    final imageUrl = '${AppConstants.itemsPath}${itemInfo.item.thumbnail}';
    double price = (itemInfo.price ?? 0).toDouble();
    if (itemInfo.storeItemVariation?.isNotEmpty ?? false) {
      price += itemInfo.storeItemVariation!.first.price ?? 0;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteNames.itemDetailScreen,
        arguments: itemInfo,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: CustomImage(
                path: imageUrl,
                width: size.width * 0.4,
                height: size.height * 0.15,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 14),
            // Main info section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Item name
                    Text(
                      itemInfo.item.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Store name and verified
                    if (store != null)
                      Row(
                        children: [
                          Flexible(
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
                          Flexible(
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
            ),
          ],
        ),
      ),
    );
  }
}
