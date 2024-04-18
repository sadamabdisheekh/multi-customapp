part of 'signin_cubit.dart';



class SigninState extends Equatable {
  const SigninState({required this.siginStateType,required this.customError});
  final NetworkStateType siginStateType;
  final CustomError? customError; 

  factory SigninState.initial() {
    return const SigninState(siginStateType: NetworkStateType.initial,customError: null);
  }

  @override
  List<Object> get props => [];
}


