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

// logout

class SigninStateLogoutLoading extends SigninState {}

class SigninStateLogoutError extends SigninState {
  final CustomError error;

  const SigninStateLogoutError({required this.error});
}

class SigninStateLogOut extends SigninState {
  final String msg;
  final int statusCode;

  const SigninStateLogOut(this.msg, this.statusCode);

  @override
  List<Object> get props => [msg, statusCode];
}