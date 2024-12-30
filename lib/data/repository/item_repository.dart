import 'package:dartz/dartz.dart';
import 'package:multi/data/models/attribute_model.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';
import 'package:multi/data/models/item_details_model.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/providers/error/failure.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../remote_urls.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<ItemsModel>>> getItems(Map<String, dynamic> body);
  Future<Either<Failure, List<Attribute>>> getItemAttributes(Map<String, dynamic> body);

  Future<Either<Failure, ItemDetailsModel>> getItemDetials(int storeItemId);

  Future<Either<Failure, dynamic>> addToCart(Map<String, dynamic> body);

  Future<Either<Failure, List<CartResponseModel>>> getCartItems();

  Future<Either<Failure, dynamic>> incrementQuantity(int storeItemId);

  Future<Either<Failure, dynamic>> decrementQuantity(int storeItemId);
  Future<Either<Failure, String>> removeCartItem(int storeItemId);


}

class ItemsRepositoryImp extends ItemsRepository {
  final RemoteDataSource remoteDataSource;
  ItemsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ItemsModel>>> getItems(
      Map<String, dynamic> body) async {
    try {
      final resp = await remoteDataSource.httpPost(
          url: RemoteUrls.items, body: body) as List;
     final result =
          List<ItemsModel>.from(resp.map((e) => ItemsModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<Attribute>>> getItemAttributes(
      Map<String, dynamic> body) async {
    try {
      final resp = await remoteDataSource.httpPost(
          url: RemoteUrls.itemAttributes, body: body) as List;
     final result =
          List<Attribute>.from(resp.map((e) => Attribute.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ItemDetailsModel>> getItemDetials(
      int storeItemId) async {
    try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getItemDetails(storeItemId));
      final result = ItemDetailsModel.fromMap(resp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addToCart(Map<String, dynamic> body) async {
    try {
      final resp = await remoteDataSource.httpPost(
          url: RemoteUrls.addToCart, body: body) as Map<String, dynamic>;
      return Right(resp);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CartResponseModel>>> getCartItems() async {
    try {
      final resp = await remoteDataSource.httpGet(url: RemoteUrls.getCartItems)
          as List;
    final result =
          List<CartResponseModel>.from(resp.map((e) => CartResponseModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> incrementQuantity(int storeItemId) async {
    try {
      final resp = await remoteDataSource.httpGet(url: RemoteUrls.incrementquantity(storeItemId))
          as dynamic;
      return Right(resp);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> decrementQuantity(int storeItemId) async{
      try {
      final resp = await remoteDataSource.httpGet(url: RemoteUrls.decrementquantity(storeItemId))
          as dynamic;
      return Right(resp);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  
  @override
  Future<Either<Failure, String>> removeCartItem(int storeItemId) async {
    try {
      final resp = await remoteDataSource.httpGet(url: RemoteUrls.removecartitem(storeItemId));
      return Right(resp['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
