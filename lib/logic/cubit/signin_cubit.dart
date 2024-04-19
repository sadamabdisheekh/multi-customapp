import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/user_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/auth_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository _authRepository;
  SigninCubit({required authRepository})
      : _authRepository = authRepository,
        super(SigninInitialState());

  login(Map<String, dynamic> body) async{
    emit(SigninLoadingState());

     final result = await _authRepository.login(body);
    result.fold(
      (failure) {
        var errorState = SigninErrorState(error: CustomError(statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(SigninLoadedState(user: value));
      },
    );

  }
}
