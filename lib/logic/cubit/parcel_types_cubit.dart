import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/parcel_types.dart';
import 'package:multi/data/repository/parcel_repository.dart';

part 'parcel_types_state.dart';

class ParcelTypesCubit extends Cubit<ParcelTypesState> {
  final ParcelRepository _parcelRepository;
  ParcelTypesCubit({required parcelRepository}) :_parcelRepository = parcelRepository, super(ParcelTypesInitial());

  getParcelTypes() async {
  try {
    emit(ParcelTypesLoading());
    final result = await _parcelRepository.getParcelTypes();
    result.fold(
      (failure) {
        emit(ParcelTypesError(message: failure.message));
      }, 
      (result) {
        emit(ParcelTypesLoaded(parcelTypes: result));
      });

  }catch (e) {
    emit(ParcelTypesError(message: 'Failed to Load Parcel types ${e.toString()}'));
  }
}
}