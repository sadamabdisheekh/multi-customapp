import 'package:flutter/material.dart';
import 'package:multi/data/models/items_model.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/router_names.dart';
import '../../../widgets/custom_images.dart';

class ItemGridView extends StatelessWidget {
  const ItemGridView({super.key, required this.item});

  final ItemsModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.itemDetailScreen,
            arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProductImage(AppConstants.itemsPath + item.item.thumbnail),
            const Divider(height: 1,thickness: 0.1,),
            _buildProductDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), 
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: CustomImage(
          path: image,
          fit: BoxFit.contain,
          height: 150,
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Name
          Text(
            item.item.name,
            // style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Store Name and Verified Icon
          Row(
            children: [
              Flexible(
                child: Text(
                  item.store.name,
                  // style: theme.textTheme.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4,),
              Icon(Icons.check_circle, size: 16, color: theme.primaryColor),
            ],
          ),
          const SizedBox(height: 4),

          // Price
          Text(
            '\$${item.price}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Address (if available)
          if (item.store.address != null)
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item.store.address!,
                    // style: theme.textTheme.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
