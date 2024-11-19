import 'package:flutter/material.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';
import '../custom_images.dart';

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeSmall,
        vertical: Dimensions.paddingSizeDefault,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.all(Dimensions.fontSizeOverSmall),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200, width: 2),
              ),
              child: ClipOval(
                child: CustomImage(
                  path: imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Expanded(
              child: Text(
                name,
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
