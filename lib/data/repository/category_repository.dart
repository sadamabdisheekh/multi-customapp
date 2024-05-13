import 'package:dartz/dartz.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/providers/error/failure.dart';
import '../providers/datasources/remote_data_source.dart';
import '../providers/error/exception.dart';
import '../remote_urls.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategory();
}

class CategoryRepositoryImp extends CategoryRepository {
  final RemoteDataSource remoteDataSource;
  CategoryRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategory() async {
    try {
      final resp =
          await remoteDataSource.httpGet(url: RemoteUrls.category) as List;
      final result =
          List<CategoryModel>.from(resp.map((e) => CategoryModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
