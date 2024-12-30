part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationChanged extends LocationState {}

final class LocationError extends LocationState {
  final int code;
  final String message;

  const LocationError({required this.code, required this.message});
}

final class LocationLoaded extends LocationState {
  final String location;

  const LocationLoaded({required this.location});
}
