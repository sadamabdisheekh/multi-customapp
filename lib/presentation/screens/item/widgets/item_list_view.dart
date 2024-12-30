import 'package:flutter/material.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

import '../../../../data/models/items_model.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({super.key, required this.itemInfo});

  final ItemsModel itemInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.itemDetailScreen,arguments: itemInfo);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2, // Adjust the flex value as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImage(
                  path: '${AppConstants.itemsPath}${itemInfo.item.thumbnail}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(flex: 3, child: _buildDetails(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(itemInfo.item.name, fontSize: 16, fontWeight: FontWeight.w500),
        const SizedBox(height: 4),
        _buildText('\$${itemInfo.price}', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
        const SizedBox(height: 8),
        if (itemInfo.store.address != null)
          _buildLocation(itemInfo.store.address!),
        const SizedBox(height: 4),
        _buildText(itemInfo.store.name, fontSize: 14, color: Colors.grey),
      ],
    );
  }

  Widget _buildText(String text, {double fontSize = 14, FontWeight fontWeight = FontWeight.normal, Color? color}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildLocation(String address) {
    return Row(
      children: [
        const Icon(Icons.location_pin, size: 16, color: Colors.purple),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
