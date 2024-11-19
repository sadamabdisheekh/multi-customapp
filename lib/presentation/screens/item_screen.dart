import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import '../widgets/items/item_section.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String appBarTitle = '';

  bool get isSubCategory => widget.category.children.isNotEmpty;

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.category.name;
    _fetchInitialData();
  }

  void _fetchInitialData() {
    if (isSubCategory) {
      context.read<CategoryCubit>().getCategory(widget.category.id);
    } else {
      context.read<ItemsCubit>().getItems({"categoryId": widget.category.id});
    }
  }

  void _updateTitle(String newTitle) {
    setState(() {
      appBarTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: isSubCategory
          ? BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryLoaded) {
                  return _buildCategoryList(state.categoryList);
                } else if (state is CategoryError) {
                  return const Center(child: Text('Error loading subcategories'));
                }
                return const Center(child: Text('No subcategories available'));
              },
            )
          : const ItemsSection(),
    );
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category.name),
          onTap: () {
            _updateTitle(category.name);
            context.read<CategoryCubit>().getCategory(category.id);
          },
        );
      },
    );
  }
}
