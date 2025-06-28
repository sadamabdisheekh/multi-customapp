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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImage(
                path: imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemInfo.item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (store?.address != null)
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 16, color: Colors.purple),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            store!.address!,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  if (store != null)
                    Row(
                      children: [
                        const Icon(Icons.store, size: 16, color: Colors.purple),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            store.name,
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.verified, size: 16, color: Colors.green),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
