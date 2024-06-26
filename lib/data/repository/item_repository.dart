import 'package:dartz/dartz.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/data/providers/error/failure.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../remote_urls.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<ItemsModel>>> getItems(Map<String,dynamic> body);
}

class ItemsRepositoryImp extends ItemsRepository {
  final RemoteDataSource remoteDataSource;
  ItemsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ItemsModel>>> getItems(Map<String,dynamic> body) async {
    try {
      final resp =
          await remoteDataSource.httpPost(url: RemoteUrls.items,body: body) as List;
      final result =
          List<ItemsModel>.from(resp.map((e) => ItemsModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
