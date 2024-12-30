import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/presentation/screens/item/widgets/icon_text_button.dart';
import 'package:multi/presentation/screens/item/widgets/item_grid_view.dart';
import 'package:multi/presentation/shimers/item_grid.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';

import 'widgets/filter_content.dart';
import 'widgets/item_list_view.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late String appBarTitle;
  bool isListView = false;

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.category.name;
    _fetchInitialData();
  }

  void _fetchInitialData() {
    context.read<CategoryCubit>().getCategory(widget.category.id);
    context.read<ItemsCubit>().getItems({"categoryId": widget.category.id});
    context.read<ItemsCubit>().getItemAttributes({"categoryId": widget.category.id});
  }

  void _updateTitle(String newTitle) {
    setState(() {
      appBarTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async {
          _fetchInitialData();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(appBarTitle),
            ),
            CategorySection(
              categoryId: widget.category.id,
              updateTitle: _updateTitle,
            ),
            SliverToBoxAdapter(
              child: FilterAndViewOptions(
                isListView: isListView,
                categoryId: widget.category.id,
                toggleView: () => setState(() {
                  isListView = !isListView;
                }),
              ),
            ),
            ItemsSection(isListView: isListView),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final Function(String) updateTitle;
  final int categoryId;

  const CategorySection({
    super.key,
    required this.updateTitle,
    required this.categoryId
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        buildWhen: (previous, current) => current is CategoryLoaded && current.categoryList.isNotEmpty,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            
            return _CategoryList(
              categoryId: categoryId,
              categories: state.categoryList,
              updateTitle: updateTitle,
            );
          } else if (state is CategoryError) {
            return const Center(child: Text('Error loading subcategories'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CategoryList extends StatefulWidget {
  const _CategoryList({required this.categories, required this.updateTitle, required this.categoryId});

  final List<CategoryModel> categories;
  final Function(String) updateTitle;
  final int categoryId;

  @override
  State<_CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<_CategoryList> {
  int selectedCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    final allCategories = [
      CategoryModel.fromMap(const {"id": 0, "name": 'All'}),
      ...widget.categories
    ];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final category = allCategories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(category.name),
              selected: selectedCategoryId == index,
              onSelected: (selected) {
                if (selected) {
                  setState(() => selectedCategoryId = index);
                  final categoryId = category.id == 0 ? widget.categoryId : category.id;
                  context.read<ItemsCubit>().getItems({"categoryId": categoryId});
                  widget.updateTitle(category.name);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterAndViewOptions extends StatefulWidget {
  final bool isListView;
  final VoidCallback toggleView;
  final int categoryId;

 const FilterAndViewOptions({
    super.key,
    required this.isListView,
    required this.toggleView,
    required this.categoryId
  });

  @override
  State<FilterAndViewOptions> createState() => _FilterAndViewOptionsState();
}

class _FilterAndViewOptionsState extends State<FilterAndViewOptions> {
  List<int> selectedValues = []; 

  void _openFullScreenFilter(BuildContext context, int categoryId) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Filter',
    pageBuilder: (context, _, __) {
      return FilterContent(categoryId: categoryId, selectedValues: selectedValues,);
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconTextButton(
            icon: Icons.filter_list,
            text: 'Filter By',
           onTap: () => _openFullScreenFilter(context, widget.categoryId),
          ),
          IconTextButton(
            icon: Icons.sort,
            text: 'Sort By',
            onTap: () {},
          ),
          IconTextButton(
            icon: widget.isListView ? Icons.grid_view : Icons.list,
            text: '',
            onTap: widget.toggleView,
          ),
        ],
      ),
    );
  }
}

class ItemsSection extends StatelessWidget {
  final bool isListView;

  const ItemsSection({super.key, required this.isListView});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: BlocBuilder<ItemsCubit, ItemsState>(
        builder: (context, state) {
          if (state is ItemsLoading) {
            return itemShimmerGrid();
          }
          if (state is ItemsLoaded) {
            return isListView
                ? ItemList(items: state.itemsList)
                : ItemGrid(items: state.itemsList);
          }
          if (state is ItemsError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(state.error.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16)),
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<ItemsModel> items;

  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ItemListView(itemInfo: items[index]),
        childCount: items.length,
      ),
    );
  }
}

class ItemGrid extends StatelessWidget {
  final List<ItemsModel> items;

  const ItemGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 2/3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => ItemGridView(item: items[index]),
        childCount: items.length,
      ),
    );
  }
}

