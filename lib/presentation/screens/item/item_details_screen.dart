// item_detail_screen.dart
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
  final ItemsModel item;

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
          if (state is ItemDetailsLoadingState) return const Center(child: CircularProgressIndicator());
          if (state is ItemDetailsErrorState) return Center(child: Text(state.error.message));
          if (state is ItemDetailsLoadedState) {
            final itemDetails = state.itemDetails;
            final variations = itemDetails.variations ?? [];
            _selectedVariation = _selectedVariation ?? (variations.isNotEmpty ? variations.first : null);
            return _buildItemDetails(itemDetails);
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoadedState) return _buildBottomBar(state.itemDetails);
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildItemDetails(ItemDetailsModel item) {
    final images = item.images?.map((e) => e.imageUrl).toList() ?? [item.thumbnail];
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
            child: _buildProductInfo(item),
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

  Widget _buildProductInfo(ItemDetailsModel item) {
    final price = _selectedVariation?.price ?? item.basePrice ?? 0.0;
    final stock = _selectedVariation?.stock ?? item.stock ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('\$$price', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('Availability:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Text(
              stock > 0 ? '$stock Items Available' : 'Out Of Stock',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: stock > 0 ? Colors.black : Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(item.description ?? '', style: const TextStyle(fontSize: 16, height: 1.5)),
        const SizedBox(height: 16),
        ProductVariantSelector(
          attributes: item.attributes ?? [],
          variants: item.variations ?? [],
          initialSelectedVariation: _selectedVariation,
          onVariationSelected: (v) => setState(() => _selectedVariation = v),
        ),
      ],
    );
  }

  Widget _buildBottomBar(ItemDetailsModel item) {
    final price = _selectedVariation?.price ?? item.basePrice ?? 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$$price', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
          InkWell(
            onTap: () => Navigator.pushNamed(context, RouteNames.cartScreen),
            child: CartBadge(count: context.read<CartCubit>().cartCount.toString()),
          ),
          BlocBuilder<AddToCartCubit, AddToCartState>(
            builder: (context, state) {
              if (state is AddToCartLoading) return const CircularProgressIndicator();

              return ElevatedButton(
                onPressed:  () {
                        final body = {
                          "userId": context.read<SigninCubit>().customerInfo?.userId,
                          "quantity": 1,
                          "storeId": item.store.id,
                          "itemId": item.itemId,
                          "price": price,
                          "storeItemId": item.storeItemId,
                          if (_selectedVariation != null) "variationId": _selectedVariation!.id,

                        };
                        print(body);
                        // context.read<AddToCartCubit>().addToCart(body);
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 18)),
              );
            },
          ),
        ],
      ),
    );
  }
}
