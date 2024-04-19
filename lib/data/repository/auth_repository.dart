import 'package:dartz/dartz.dart';
import 'package:multi/data/models/user_model.dart';
import '../providers/datasources/local_data_source.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../providers/error/failure.dart';
import '../remote_urls.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(Map<String, dynamic> body);
  Future<Either<Failure, UserModel>> signup(Map<String, dynamic> body);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  AuthRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, UserModel>> login(Map<String, dynamic> body) async {
    try {
      final resp =
          await remoteDataSource.httpPost(url: RemoteUrls.login, body: body);
      final result = UserModel.fromMap(resp);
      localDataSource.cacheUserResponse(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

   @override
  Future<Either<Failure, UserModel>> signup(Map<String, dynamic> body) async {
    try {
      final resp =
          await remoteDataSource.httpPost(url: RemoteUrls.signup, body: body);
      final result = UserModel.fromMap(resp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
