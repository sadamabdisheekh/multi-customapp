import 'package:flutter/material.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/utilits/utility.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/models/category.dart';
import '../../../widgets/custom_images.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            leading: Padding(
              padding: Utils.symmetric(h: 4.0,v: 8.0),
              child: ClipOval(
                child: CustomImage(
                  path: AppConstants.categoryPath + categories[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(categories[index].name), 
            onTap: () {
              Navigator.pushNamed(context, RouteNames.itemScreen,arguments: categories[index]);
            },
          );
        },
        childCount: categories.length,
      ),
    );
  }
}