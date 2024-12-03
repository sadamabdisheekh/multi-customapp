import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/add_to_cart_cubit.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/location_cubit.dart';
import '../../constants/dimensions.dart';
import '../../constants/styles.dart';
import '../../logic/cubit/cart_cubit.dart';
import '../../logic/utility.dart';
import '../widgets/banner.dart';
import '../widgets/home/modules.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  void initState() {
    context.read<CartCubit>().getCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationCubit>().userCurrentLocationPossion;
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
         if (state is AddToCartLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is AddToCartLoaded) {
            context.read<CartCubit>().getCartProducts();
            Utils.showSnackBar(context, state.message);
          } else if (state is AddToCartError) {
            Utils.errorSnackBar(context, state.error.message);
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          location != null
                              ? location.latitude.toString()
                              : 'no location',
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Icon(
                          Icons.expand_more,
                          size: 18,
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Icon(
                          CupertinoIcons.bell,
                          size: 25,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return   SizedBox(
          height: MediaQuery.of(context).size.height, // Full screen height
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
                    }
                    if (state is HomeErrorState) {
                      return Center(
                        child: Text(state.error.message),
                      );
                    }
                    if (state is HomeLoadedState) {
                      return Center(
                        child: Container(
                          width: Dimensions.webMaxWidth,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BannerView(
                                isFeatured: false,
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraLarge,
                              ),
                              ModuleWidget(products: state.response),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
