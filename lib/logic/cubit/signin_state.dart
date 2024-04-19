part of 'signin_cubit.dart';

class SigninState extends Equatable {
  const SigninState();
  @override
  List<Object> get props => [];
}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninErrorState extends SigninState {
  final CustomError error;

  const SigninErrorState({required this.error});
}

class SigninLoadedState extends SigninState {
  final UserModel user;

  const SigninLoadedState({required this.user});
}
