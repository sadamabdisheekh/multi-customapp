import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/presentation/theme/ligth_theme.dart';

import 'logic/state_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StateInjector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: StateInjector.repositoryProviders,
      child: MultiBlocProvider(
        providers: StateInjector.blocProviders,
        child: GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: light(),
          onGenerateRoute: RouteNames.generateRoute,
          initialRoute: RouteNames.splashScreen,
        ),
      ),
    );
  }
}
