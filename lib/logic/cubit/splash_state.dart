part of 'splash_cubit.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashError extends SplashState {
  final CustomError error;

  const SplashError({required this.error});
}

final class SplashLoaded extends SplashState {
  final dynamic list;

  const SplashLoaded({required this.list});
}
