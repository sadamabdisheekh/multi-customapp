import 'package:dartz/dartz.dart';
import 'package:multi/data/models/customer_model.dart';
import '../providers/datasources/local_data_source.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../providers/error/failure.dart';
import '../remote_urls.dart';

abstract class AuthRepository {
  Either<Failure, CustomerModel> getCashedUserInfo();
  Future<Either<Failure, CustomerModel>> login(Map<String, dynamic> body);
  Future<Either<Failure, String>> logOut();
  Future<Either<Failure, CustomerModel>> signup(Map<String, dynamic> body);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Either<Failure, CustomerModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      // final result = await remoteDataSource.logOut(token);
      await localDataSource.clearUserProfile();
      return const Right('logout successfull');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> login(
      Map<String, dynamic> body) async {
    try {
      final resp =
          await remoteDataSource.httpPost(url: RemoteUrls.login, body: body);
      final result = CustomerModel.fromMap(resp);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CustomerModel>> signup(
      Map<String, dynamic> body) async {
    try {
      final resp =
          await remoteDataSource.httpPost(url: RemoteUrls.signup, body: body);
      final result = CustomerModel.fromMap(resp);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
