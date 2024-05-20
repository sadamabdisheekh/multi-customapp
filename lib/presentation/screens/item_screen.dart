import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/logic/cubit/sub_category_cubit.dart';
import 'package:multi/presentation/widgets/categories/sub_category2.dart';
import 'package:multi/presentation/widgets/variation.dart';

import '../../constants/dimensions.dart';
import '../widgets/items/items.dart';

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
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isSubCategory) ...[
                BlocBuilder<SubCategoryCubit, SubCategoryState>(
                  builder: (context, state) {
                    if (state is SubCategoryLoaded) {
                      return SubCategory2(
                        category: widget.category,
                          subCategoryList: state.subCategoryList
                          );
                    }
                    return const SizedBox();
                  },
                )
              ],
              BlocBuilder<ItemsCubit, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsLoaded) {
                    return Container();
                  }
                  return const SizedBox();
                },
              ),
              const ItemWidget(
                itemsList: [],
              ),
              const AddonView(item: []),
              const NewVariationView(
                  item: [],
                  discount: 0,
                  discountType: '',
                  showOriginalPrice: true),
            ],
          ),
        ),
      ),
    );
  }
}
