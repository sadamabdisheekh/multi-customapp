import 'package:dartz/dartz.dart';
import 'package:multi/data/models/parcel_types.dart';
import 'package:multi/data/providers/error/exception.dart';
import 'package:multi/data/providers/error/failure.dart';
import 'package:multi/data/remote_urls.dart';

import '../providers/datasources/remote_data_source.dart';


abstract class ParcelRepository {
  Future<Either<Failure, List<ParcelTypesModel>>> getParcelTypes();

}

class ParcelRepositoryImp extends ParcelRepository {
  ParcelRepositoryImp({required this.remoteDataSource});
   final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<ParcelTypesModel>>> getParcelTypes() async {
    try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getParcelTypes) as List;
      final result =
          List<ParcelTypesModel>.from(resp.map((e) => ParcelTypesModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}