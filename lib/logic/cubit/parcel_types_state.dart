part of 'parcel_types_cubit.dart';

sealed class ParcelTypesState extends Equatable {
  const ParcelTypesState();

  @override
  List<Object> get props => [];
}

final class ParcelTypesInitial extends ParcelTypesState {}

final class ParcelTypesLoading extends ParcelTypesState {}

final class ParcelTypesError extends ParcelTypesState {
  final String message;
  const ParcelTypesError({required this.message});
}

final class ParcelTypesLoaded extends ParcelTypesState {
  final List<ParcelTypesModel> parcelTypes;
  const ParcelTypesLoaded({required this.parcelTypes});
}