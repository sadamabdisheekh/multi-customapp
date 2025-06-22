import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
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
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: CustomImage(
                  path: AppConstants.categoryPath + category.image,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                '${category.children.length} Subcategories',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
              onTap: () {
                if (category.children.isNotEmpty) {
                  context.read<CategoryCubit>().getCategory(category.id);
                }else {
                  Navigator.pushNamed(
                    context,
                    RouteNames.itemScreen,
                    arguments: category,
                  );
                }
              },
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }
}
