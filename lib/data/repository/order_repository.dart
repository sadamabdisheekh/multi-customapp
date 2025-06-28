import 'package:dartz/dartz.dart';
import 'package:multi/data/models/orders/order_details.dart';
import 'package:multi/data/models/orders/order_model.dart';
import 'package:multi/data/models/payment_methods.dart';
import 'package:multi/data/providers/error/exception.dart';
import 'package:multi/data/providers/error/failure.dart';
import 'package:multi/data/remote_urls.dart';

import '../providers/datasources/remote_data_source.dart';


abstract class OrderRepository {
  Future<Either<Failure, dynamic>> getPaymentMethods();

  Future<Either<Failure, String>> createOrder(Map<String, dynamic> body);

  Future<Either<Failure, List<OrderModel>>> getOrders(); 

   Future<Either<Failure, OrderDetailsModel>> getOrderDetails(int orderId); 

}

class OrderRepositoryImp extends OrderRepository {
  OrderRepositoryImp({required this.remoteDataSource});
   final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, dynamic>> getPaymentMethods() async {
    try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getPaymentMethods) as List;
      final result =
          List<PaymentMethodsModel>.from(resp.map((e) => PaymentMethodsModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

   @override
  Future<Either<Failure, String>> createOrder(Map<String,dynamic> body) async {
    try {
      final resp = await remoteDataSource.httpPost(
          url: RemoteUrls.createOrder,body: body) as dynamic;
      return Right(resp['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
     try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getUserOrders) as List;
      final result =
          List<OrderModel>.from(resp.map((e) => OrderModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, OrderDetailsModel>> getOrderDetails(orderId) async {
    try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getOrderDetails(orderId));
      final result =
          OrderDetailsModel.fromMap(resp as Map<String, dynamic>);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}