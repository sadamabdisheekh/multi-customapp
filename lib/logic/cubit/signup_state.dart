part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState();


  @override
  List<Object> get props => [];
}

final class SignupInitialState extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupErrorState extends SignupState {
  final CustomError error;
  const SignupErrorState({required this.error});
}

final class SignupLoadedState extends SignupState {
  final dynamic response;
  const SignupLoadedState({required this.response});
}