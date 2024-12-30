import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/dimensions.dart';
import '../../../../constants/styles.dart';
import '../../../../data/models/category.dart';
import '../../../../data/router_names.dart';
import '../../../widgets/custom_images.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
        mainAxisExtent: 128,
        crossAxisSpacing:
            MediaQuery.of(context).size.width * 0.04, // 4% spacing
        mainAxisSpacing: MediaQuery.of(context).size.width * 0.04, // 4% spacing
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.itemScreen,
          arguments: category,
        );
      },
      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.fontSizeOverSmall),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: ClipOval(
              child: CustomImage(
                path: AppConstants.categoryPath + category.image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text(
            category.name,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
        },
        childCount: categories.length,
      ),
    );
  }
}