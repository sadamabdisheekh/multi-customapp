import 'package:dartz/dartz.dart';
import 'package:multi/data/models/modules_model.dart';
import 'package:multi/data/providers/error/failure.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../remote_urls.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ModulesModel>>> loadHomeData();
}

class HomeRepositoryImp extends HomeRepository {
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ModulesModel>>> loadHomeData() async {
    try {
      final resp =
          await remoteDataSource.httpGet(url: RemoteUrls.modulesList) as List;
      final result =
          List<ModulesModel>.from(resp.map((e) => ModulesModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
