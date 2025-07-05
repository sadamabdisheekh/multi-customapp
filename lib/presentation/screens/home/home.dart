import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/add_to_cart_cubit.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/helpers/get_location.dart';
import 'package:multi/presentation/screens/home/widgets/cart_badge.dart';
import 'package:multi/presentation/widgets/page_refresh.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';
import '../../../logic/utilits/utility.dart';
import '../../widgets/banner.dart';
import '../../widgets/home/modules.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartItems();
    _initLocationServices();
    
  }
  String userAddress = '';
  

Future<void> _initLocationServices() async {
  try {
    final position = await LocationService.getCurrentLocation();
    final place = await LocationService.getAddressFromLatLng(
      position.latitude,
      position.longitude,
    );

    String country = place?.country ?? '';
      String region = place?.administrativeArea ?? '';
      String district = place?.subAdministrativeArea ?? '';
    String address = '$district, $region $country';

    context.read<HomeCubit>()
      ..userPlaceMark = place
      ..position = position;

    setState(() => userAddress = address);
  } on LocationException catch (e) {
    Utils.showSnackBar(context, e.message);
  }
}



  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: _handleAddToCartState,
      child: PageRefresh(
        onRefresh: () async {
          await Future.wait<void>([
            context.read<CartCubit>().getCartItems() as Future<void>,
            context.read<HomeCubit>().loadHomeData() as Future<void>,
          ]);

        },
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildAppBar(),
                _buildHomeContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAddToCartState(BuildContext context, AddToCartState state) {
    if (state is AddToCartLoading) {
      Utils.loadingDialog(context);
    } else {
      Utils.closeDialog(context);

      if (state is AddToCartLoaded) {
        context.read<CartCubit>().getCartItems();
        Utils.showSnackBar(context, state.message);
      } else if (state is AddToCartError) {
        Utils.errorSnackBar(context, state.error.message);
      }
    }
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
                children: [
                  Text(
                    userAddress,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Icon(Icons.expand_more, size: 18),
                ],
              ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cartCount = context.read<CartCubit>().cartCount;
              return InkWell(
                onTap: () {
                  if (cartCount != 0) {
                    Navigator.pushNamed(context, RouteNames.cartScreen);
                  }
                },
                child: CartBadge(count: cartCount.toString()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return  _buildLoading();
          } else if (state is HomeErrorState) {
            return _buildError(state.error.message);
          } else if (state is HomeLoadedState) {
            return _buildHomeLoaded(state.response);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget _buildHomeLoaded(dynamic response) {
    return Center(
      child: Container(
        width: Dimensions.webMaxWidth,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerView(isFeatured: false),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            ModuleWidget(products: response),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
