import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:multi/data/repository/auth_repository.dart';
import 'package:multi/data/repository/category_repository.dart';
import 'package:multi/data/repository/home_repository.dart';
import 'package:multi/logic/cubit/category_cubit.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/providers/datasources/local_data_source.dart';
import '../data/providers/datasources/remote_data_source.dart';
import 'cubit/location_cubit.dart';
import 'cubit/signin_cubit.dart';
import 'cubit/signup_cubit.dart';

class StateInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProviders = <RepositoryProvider>[
    ///network client
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),

    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(
        client: context.read<Client>(),
      ),
    ),

    RepositoryProvider<LocalDataSource>(
      create: (context) => LocalDataSourceImpl(
        sharedPreferences: context.read(),
      ),
    ),

    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImp(
          remoteDataSource: context.read<RemoteDataSource>(),
          localDataSource: context.read<LocalDataSource>()),
    ),
    RepositoryProvider<HomeRepository>(
      create: (context) => HomeRepositoryImp(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<CategoryRepository>(
      create: (context) => CategoryRepositoryImp(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    )
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
    ),
    BlocProvider<LocationCubit>(
      create: (context) => LocationCubit(),
    ),
    BlocProvider<SigninCubit>(
      create: (context) =>
          SigninCubit(authRepository: context.read<AuthRepository>()),
    ),
    BlocProvider<SignupCubit>(
      create: (context) =>
          SignupCubit(authRepository: context.read<AuthRepository>()),
    ),
    BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(homeRepository: context.read<HomeRepository>()),
    ),
    BlocProvider<CategoryCubit>(
        create: (context) => CategoryCubit(
            categoryRepository: context.read<CategoryRepository>())),
  ];
}
