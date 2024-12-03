import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/presentation/shimers/item_grid.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late String appBarTitle;
  int selectedCategoryId = 0;

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.category.name;
    _fetchInitialData();
  }

  void _fetchInitialData() {
      context.read<CategoryCubit>().getCategory(widget.category.id);
      context.read<ItemsCubit>().getItems({"categoryId": widget.category.id});
  }

  void _updateTitle(String newTitle) {
    setState(() {
      appBarTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(appBarTitle),
          ),
          _buildCategorySection(),
          _buildItemsSection(),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return SliverToBoxAdapter(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        // buildWhen: (previous, current) =>
        //     current is CategoryLoaded && current.categoryList.isNotEmpty,
        listener: (context, state) {
          if (state is CategoryLoaded && state.categoryList.isEmpty) {
            // context.read<ItemsCubit>().getItems({"categoryId": selectedCategoryId});
          }
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return _buildCategoryList(state.categoryList);
          } else if (state is CategoryError) {
            return const Center(child: Text('Error loading subcategories'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    return SizedBox(
      height: categories.isNotEmpty ? 60 : 0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(category.name),
              selected: appBarTitle == category.name,
              onSelected: (selected) {
                if (selected) {
                  selectedCategoryId = category.id;
                  _updateTitle(category.name);
                  context.read<CategoryCubit>().getCategory(category.id);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemsSection() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: BlocBuilder<ItemsCubit, ItemsState>(
        builder: (context, state) {
          if (state is ItemsLoading) {
            return itemShimmerGrid();
          }
          if (state is ItemsLoaded) {
            return _buildItemGrid(state.itemsList);
          }
          if (state is ItemsError) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.error.message, style: const TextStyle(color: Colors.red, fontSize: 16))),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
    );
  }

  Widget _buildItemGrid(List<ItemsModel> itemsList) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 3 / 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = itemsList[index];
          return ProductContainer(item: item);
        },
        childCount: itemsList.length,
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  final ItemsModel item;

  const ProductContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.itemDetailScreen,arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(AppConstants.itemsPath + item.item.thumbnail),
             Divider(color: Theme.of(context).disabledColor,),
            _buildProductDetails(context,item),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String image) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: CustomImage(path: image, fit: BoxFit.contain, width: double.infinity),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context,ItemsModel item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.item.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                item.store.name,
                style: const TextStyle(fontWeight: FontWeight.normal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 5,),
              Icon(Icons.check_circle, size: 14, color: Theme.of(context).primaryColor),

            ],
          ),
          const SizedBox(height: 4),
          Text(
            '\$${item.price}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
           item.store.address != null ? Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.store.address ?? '', // Replace with your location data
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
