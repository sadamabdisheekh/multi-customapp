import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/attribute_model.dart';
import 'package:multi/data/models/item_details_model.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/add_to_cart_cubit.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/cubit/item_details_cubit.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/utility.dart';
import 'package:multi/presentation/screens/home/widgets/cart_badge.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

class ItemDetailScreen extends StatefulWidget {
  final ItemsModel item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ItemDetailsCubit>().getItemDetails(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.item.name),
      ),
      body: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemDetailsErrorState) {
            return Center(child: Text(state.error.message));
          } else if (state is ItemDetailsLoadedState) {
            return _buildItemDetails(state.itemDetails);
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
        builder: (context, state) {
          if (state is ItemDetailsLoadedState) {
            return _buildBottomBar(state.itemDetails);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildItemDetails(ItemDetailsModel itemDetails) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildProductCarousel(itemDetails),
              _buildImageCounter(itemDetails),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildProductInfo(itemDetails),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCarousel(ItemDetailsModel itemDetails) {
    final item = itemDetails.itemStore.item;
    final images = item.images?.isNotEmpty == true
        ? item.images!.map((e) => e.imageUrl).toList()
        : [item.thumbnail];

    return CarouselSlider(
      items: images.map((img) => _buildCarouselImage(img)).toList(),
      options: CarouselOptions(
        height: 300,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlay: false,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCarouselImage(String imgUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      child: CustomImage(
        path: AppConstants.itemsPath + imgUrl,
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }

  Widget _buildImageCounter(ItemDetailsModel itemDetails) {
    final item = itemDetails.itemStore.item;
    final images = item.images?.isNotEmpty == true
        ? item.images!.map((e) => e.imageUrl).toList()
        : [item.thumbnail];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${_currentIndex + 1}/${images.length}',
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductInfo(ItemDetailsModel itemDetails) {
    final item = itemDetails.itemStore.item;
    final storeItem = itemDetails.itemStore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('\$${itemDetails.itemStore.price}',
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        const SizedBox(height: 16),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
              children: [
                const Text(
                  'Availability:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  storeItem.availableStock > 0
                      ? '${storeItem.availableStock} Items Available'
                      : 'Out Of Stock',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: storeItem.availableStock > 0 ? Colors.black : Colors.red,
                  ),
                ),
              ],
              ),
              if (item.itemUnit != null) Container(
                padding: Utils.symmetric(h: 6.0,v: 4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Text(item.itemUnit!.name,
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ), 
                ),
              )
           ],
         ),
        const SizedBox(height: 16),
        const Text('Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(item.description ?? '',
            style: const TextStyle(fontSize: 16, height: 1.5)),
        _buildProductVariants(itemDetails.attributes)
      ],
    );
  }

  Widget _buildBottomBar(ItemDetailsModel itemDetails) {
    final price = itemDetails.itemStore.price;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$$price',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cartCount = context.read<CartCubit>().cartCount.toString();
              return InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.cartScreen);
              },
              child: CartBadge(count: cartCount)
              );
            },
          ),
          BlocBuilder<AddToCartCubit, AddToCartState>(
            builder: (context, state) {
              if (state is AddToCartLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> body = {
                    "customerId": context.read<SigninCubit>().customerInfo?.id,
                    "quantity": 1,
                    "storeId": itemDetails.itemStore.store.id,
                    "itemId": itemDetails.itemStore.item.id,
                    "price": itemDetails.itemStore.price,
                    "storeItemId": itemDetails.itemStore.id
                  };
                  context.read<AddToCartCubit>().addToCart(body);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child:
                    const Text('Add to Cart', style: TextStyle(fontSize: 18)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductVariants(List<Attribute> variants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Variants',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...variants.map((variant) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                variant.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8.0,
                children: variant.values
                    .map(
                      (value) => Chip(
                        label: Text(value.name),
                        backgroundColor: Colors.grey[200],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }
}
