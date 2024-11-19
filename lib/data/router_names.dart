import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/repository/category_repository.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/presentation/screens/authentication/signup.dart';
import 'package:multi/presentation/screens/categories.dart';
import 'package:multi/presentation/screens/home.dart';
import 'package:multi/presentation/screens/item_screen.dart';

import '../presentation/screens/authentication/signin.dart';
import '../presentation/screens/splash_screen.dart';
import 'models/modules_model.dart';

class RouteNames {
  static const String splashScreen = '/splash';
  static const String signinScreen = '/signinScreen';
  static const String signupScreen = '/signupScreen';
  static const String otpScreen = '/otpScreen';
  static const String memberScreen = '/memberScreen';
  static const String sampleAccountScreen = '/sampleAccountScreen';
  static const String homeScreen = '/homeScreen';
  static const String categoryScreen = '/categoryScreen';
  static const String itemScreen = '/itemScreen';

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
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.categoryScreen:
        final category = settings.arguments as ModulesModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider<CategoryCubit>(create:(context) =>CategoryCubit(categoryRepository: context.read<CategoryRepository>(),),child:  CategoryScreen(category: category)));
      case RouteNames.itemScreen:
      final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  BlocProvider<CategoryCubit>(create:(context) =>CategoryCubit(categoryRepository: context.read<CategoryRepository>(),),child:  ItemScreen(category: category)));

      // case RouteNames.dahabScreen:
      //  final invoiceId = settings.arguments as int;
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) =>  Dahabscreen(invoiceId: invoiceId,));

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
