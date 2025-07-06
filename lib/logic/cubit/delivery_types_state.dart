part of 'delivery_types_cubit.dart';

sealed class DeliveryTypesState extends Equatable {
  const DeliveryTypesState();

  @override
  List<Object> get props => [];
}

final class DeliveryTypesInitial extends DeliveryTypesState {}

final class DeliveryTypesLoading extends DeliveryTypesState {}

final class DeliveryTypesError extends DeliveryTypesState {
  final String message;
  const DeliveryTypesError({required this.message});
}

final class DeliveryTypesLoaded extends DeliveryTypesState {
  final List<DeliveryTypesModel> deliverytypes;
  const DeliveryTypesLoaded({required this.deliverytypes});
}