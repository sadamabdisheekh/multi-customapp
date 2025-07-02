import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/item_details_model.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/add_to_cart_cubit.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/cubit/item_details_cubit.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/presentation/screens/home/widgets/cart_badge.dart';
import 'package:multi/presentation/screens/item/widgets/product_variation.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

class ItemDetailScreen extends StatefulWidget {
  final StoreItemsModel item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _currentImageIndex = 0;
  Variations? _selectedVariation;

  @override
  void initState() {
    super.initState();
    context.read<ItemDetailsCubit>().getItemDetails(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.item.name)),
      body: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemDetailsErrorState) {
            return Center(child: Text(state.error.message));
          } else if (state is ItemDetailsLoadedState) {
            final itemDetails = state.itemDetails;
            final variations = itemDetails.variations ?? [];
            _selectedVariation = _selectedVariation ?? (variations.isNotEmpty ? variations.first : null);
            return _buildItemDetails(context, itemDetails);
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoadedState) {
            return _buildBottomBar(context, state.itemDetails);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context, ItemDetailsModel item) {
    final theme = Theme.of(context);
    final images = item.images?.map((e) => e.imageUrl).toList() ?? [item.thumbnail];
    final price = _selectedVariation?.price ?? item.basePrice ?? 0.0;
    final stock = _selectedVariation?.stock ?? item.stock ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                items: images.map(_buildImage).toList(),
                options: CarouselOptions(
                  height: 300,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) => setState(() => _currentImageIndex = index),
                ),
              ),
              _buildImageCounter(images.length),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('\$$price',
                    style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                const SizedBox(height: 6),
                Text(
                  stock > 0 ? '$stock Items Available' : 'Out Of Stock',
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: stock > 0 ? theme.colorScheme.onSurface : theme.colorScheme.error),
                ),
                const SizedBox(height: 16),
                Text('Description',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(item.description ?? 'No description provided.',
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
                const SizedBox(height: 16),
                Text('Available Variants',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ProductVariantSelector(
                  attributes: item.attributes ?? [],
                  variants: item.variations ?? [],
                  initialSelectedVariation: _selectedVariation,
                  onVariationSelected: (v) => setState(() => _selectedVariation = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      child: CustomImage(
        path: AppConstants.itemsPath + url,
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }

  Widget _buildImageCounter(int total) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${_currentImageIndex + 1}/$total',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ItemDetailsModel item) {
  final theme = Theme.of(context);
  final price = _selectedVariation?.price ?? item.basePrice ?? 0.0;
  final cartCount = context.watch<CartCubit>().cartCount;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -4)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price section (takes available width)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Total Price', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),

        // Cart Badge
        CartBadge(count: cartCount.toString()),

        const SizedBox(width: 12),

        // Add to Cart Button
        BlocBuilder<AddToCartCubit, AddToCartState>(
          builder: (context, state) {
            if (state is AddToCartLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }
            

            return ElevatedButton.icon(
              onPressed: () {
                final body = {
                  "userId": context.read<SigninCubit>().customerInfo?.userId,
                  "quantity": 1,
                  "storeId": item.store.id,
                  "itemId": item.itemId,
                  "price": price,
                  "storeItemId": item.storeItemId,
                  if (_selectedVariation != null) "variationId": _selectedVariation!.id,
                };
                context.read<AddToCartCubit>().addToCart(body);
              },
              icon: const Icon(Icons.shopping_cart_outlined, size: 20),
              label: const Text('Add to Cart', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            );
          },
        ),
      ],
    ),
  );
}

}
