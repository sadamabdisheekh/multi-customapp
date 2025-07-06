import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:multi/data/repository/auth_repository.dart';
import 'package:multi/data/repository/category_repository.dart';
import 'package:multi/data/repository/delivery_repository.dart';
import 'package:multi/data/repository/home_repository.dart';
import 'package:multi/data/repository/item_repository.dart';
import 'package:multi/data/repository/order_repository.dart';
import 'package:multi/logic/cubit/add_to_cart_cubit.dart';
import 'package:multi/logic/cubit/cart_cubit.dart';
import 'package:multi/logic/cubit/delivery_types_cubit.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/item_details_cubit.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/logic/cubit/order_cubit.dart';
import 'package:multi/logic/cubit/order_details_cubit.dart';
import 'package:multi/logic/cubit/order_list_cubit.dart';
import 'package:multi/logic/cubit/payment_method_cubit.dart';
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
    ),
    RepositoryProvider<ItemsRepository>(
      create: (context) => ItemsRepositoryImp(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<OrderRepository>(
      create: (context) => OrderRepositoryImp(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<DeliveryRepository>(
      create: (context) => DeliveryRepositoryImp(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    )
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(
        authRepository: context.read<AuthRepository>()
      ),
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
    BlocProvider<ItemsCubit>(
      create: (context) => ItemsCubit(
        itemsRepository: context.read<ItemsRepository>(),
      ),
    ),
    BlocProvider<ItemDetailsCubit>(
      create: (context) => ItemDetailsCubit(
        itemsRepository: context.read<ItemsRepository>(),
      ),
    ),
    BlocProvider<AddToCartCubit>(
      create: (context) => AddToCartCubit(
        itemsRepository: context.read<ItemsRepository>(),
      ),
    ),
    BlocProvider<CartCubit>(
      create: (context) => CartCubit(
        itemsRepository: context.read<ItemsRepository>(),
      ),
    ),
    BlocProvider<PaymentMethodCubit>(
      create: (context) => PaymentMethodCubit(
        orderRepository: context.read<OrderRepository>(),
      ),
    ),
    BlocProvider<OrderCubit>(
      create: (context) => OrderCubit(
        orderRepository: context.read<OrderRepository>(),
      ),
    ),
     BlocProvider<OrderListCubit>(
      create: (context) => OrderListCubit(
        orderRepository: context.read<OrderRepository>(),
      )
    ),
    BlocProvider<OrderDetailsCubit>(
      create: (context) => OrderDetailsCubit(
        orderRepository: context.read<OrderRepository>(),
      )
    ),
     BlocProvider<DeliveryTypesCubit>(
      create: (context) => DeliveryTypesCubit(
        deliveryRepository: context.read<DeliveryRepository>(),
      )
    ),
  ];
}
