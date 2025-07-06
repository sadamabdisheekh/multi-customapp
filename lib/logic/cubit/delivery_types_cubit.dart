import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/delivery_types.dart';
import 'package:multi/data/repository/delivery_repository.dart';

part 'delivery_types_state.dart';

class DeliveryTypesCubit extends Cubit<DeliveryTypesState> {
  final DeliveryRepository _deliveryRepository;
  DeliveryTypesCubit({required deliveryRepository}) :_deliveryRepository = deliveryRepository, super(DeliveryTypesInitial());

  getDeliveryTypes() async {
  try {
    emit(DeliveryTypesLoading());
    final result = await _deliveryRepository.getDeliveryTypes();
    result.fold(
      (failure) {
        emit(DeliveryTypesError(message: failure.message));
      }, 
      (result) {
        emit(DeliveryTypesLoaded(deliverytypes: result));
      });

  }catch (e) {
    emit(DeliveryTypesError(message: 'Failed to Load delivery types ${e.toString()}'));
  }
}
}