import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/presentation/screens/item/widgets/icon_text_button.dart';
import 'package:multi/presentation/screens/item/widgets/item_grid_view.dart';
import 'package:multi/presentation/shimers/item_grid.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';
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
    context.read<ItemsCubit>().getItems({"categoryId": widget.category.id});
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

class FilterAndViewOptions extends StatefulWidget {
  final bool isListView;
  final VoidCallback toggleView;
  final int categoryId;

  const FilterAndViewOptions(
      {super.key,
      required this.isListView,
      required this.toggleView,
      required this.categoryId});

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
        return Container();
        // FilterContent(
        //   categoryId: categoryId,
        //   selectedValues: selectedValues,
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoaded && state.itemsList.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconTextButton(
                  icon: Icons.filter_list,
                  text: 'Filter By',
                  onTap: () =>
                      _openFullScreenFilter(context, widget.categoryId),
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
        return const SizedBox.shrink();
      },
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
            if (state.itemsList.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('No items found'),
                ),
              );
            }
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
  final List<StoreItemsModel> items;

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
  final List<StoreItemsModel> items;

  const ItemGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 2 / 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => ItemGridView(item: items[index]),
        childCount: items.length,
      ),
    );
  }
}
