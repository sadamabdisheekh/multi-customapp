part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeStateInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final CustomError error;

  const HomeErrorState({required this.error});
}

final class HomeLoadedState extends HomeState {
  final List<ModulesModel> response;

  const HomeLoadedState({required this.response});
}
