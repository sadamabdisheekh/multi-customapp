import 'package:dartz/dartz.dart';
import 'package:multi/data/models/delivery_types.dart';
import 'package:multi/data/providers/error/exception.dart';
import 'package:multi/data/providers/error/failure.dart';
import 'package:multi/data/remote_urls.dart';

import '../providers/datasources/remote_data_source.dart';


abstract class DeliveryRepository {
  Future<Either<Failure, List<DeliveryTypesModel>>> getDeliveryTypes();

}

class DeliveryRepositoryImp extends DeliveryRepository {
  DeliveryRepositoryImp({required this.remoteDataSource});
   final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<DeliveryTypesModel>>> getDeliveryTypes() async {
    try {
      final resp = await remoteDataSource.httpGet(
          url: RemoteUrls.getDeliveryTypes) as List;
      final result =
          List<DeliveryTypesModel>.from(resp.map((e) => DeliveryTypesModel.fromMap(e)));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}