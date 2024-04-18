import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/location_cubit.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/cubit/signup_cubit.dart';
import 'package:multi/presentation/theme/dark_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => SigninCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: dark(),
        onGenerateRoute: RouteNames.generateRoute,
        initialRoute: RouteNames.splashScreen,
      ),
    );
  }
}
