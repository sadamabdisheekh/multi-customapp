import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/models/orders/order_model.dart';
import 'package:multi/data/repository/category_repository.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/presentation/screens/authentication/signup.dart';
import 'package:multi/presentation/screens/cart/cart_screen.dart';
import 'package:multi/presentation/screens/category/categories.dart';
import 'package:multi/presentation/screens/checkout/checkout_screen.dart';
import 'package:multi/presentation/screens/home/home.dart';
import 'package:multi/presentation/screens/item/item_screen.dart';
import 'package:multi/presentation/screens/order/order_details.dart';
import '../presentation/screens/authentication/signin.dart';
import '../presentation/screens/item/item_details_screen.dart';
import '../presentation/screens/main_page/main_page.dart';
import '../presentation/screens/order/order_success_screen.dart';
import '../presentation/screens/splash_screen.dart';
import 'models/modules_model.dart';

class RouteNames {
  static const String splashScreen = '/splash';
  static const String mainPage = '/mainPage';
  static const String signinScreen = '/signinScreen';
  static const String signupScreen = '/signupScreen';
  static const String otpScreen = '/otpScreen';
  static const String memberScreen = '/memberScreen';
  static const String sampleAccountScreen = '/sampleAccountScreen';
  static const String homeScreen = '/homeScreen';
  static const String categoryScreen = '/categoryScreen';
  static const String itemScreen = '/itemScreen';
  static const String itemDetailScreen = '/itemDetailScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String orderSuccessScreen = '/orderSuccessScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case RouteNames.signinScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SigninScreen());
      case RouteNames.signupScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignupScreen());
      case RouteNames.mainPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainPage());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.categoryScreen:
        final module = settings.arguments as ModulesModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider<CategoryCubit>(
                create: (context) => CategoryCubit(
                      categoryRepository: context.read<CategoryRepository>(),
                    ),
                child: CategoryScreen(module: module,)));
      case RouteNames.itemScreen:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider<CategoryCubit>(
                create: (context) => CategoryCubit(
                      categoryRepository: context.read<CategoryRepository>(),
                    ),
                child: ItemScreen(category: category)));
      case RouteNames.itemDetailScreen:
        final item = settings.arguments as StoreItemsModel;
        return MaterialPageRoute(
            settings: settings, builder: (_) => ItemDetailScreen(item: item));
      case RouteNames.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
        case RouteNames.checkoutScreen:
        final cartItems = settings.arguments as List<CartResponseModel>;
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  CheckoutScreen(cartItem: cartItems));
        case RouteNames.orderSuccessScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  const OrderSuccessScreen());
      case RouteNames.orderDetailsScreen:
        final order = settings.arguments as OrderModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => OrderDetailsScreen(order: order));

        // Assuming you have an OTP screen, you can add it here
       default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
