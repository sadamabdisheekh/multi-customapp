import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/logic/cubit/sub_category_cubit.dart';
import 'package:multi/presentation/widgets/categories/sub_category2.dart';
import '../widgets/items/item_section.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool get isSubCategory => widget.category.subCategory.isNotEmpty;
  @override
  void initState() {
    if (isSubCategory) {
      context.read<SubCategoryCubit>().getSubCategory(widget.category.id);
    } else {
      Map<String, dynamic> body = {"categoryId": widget.category.id};
      context.read<ItemsCubit>().getItems(body);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isSubCategory
            ? BlocBuilder<SubCategoryCubit, SubCategoryState>(
                builder: (context, state) {
                  if (state is SubCategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SubCategoryLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SubCategory2(
                            category: widget.category,
                            subCategoryList: state.subCategoryList,
                          ),
                          const ItemsSection(),
                        ],
                      ),
                    );
                  } else if (state is SubCategoryError) {
                    return const Center(child: Text('Error loading subcategories'));
                  }
                  return const SizedBox.shrink();
                },
              )
            :  const ItemsSection(),
    );
  }
}
