import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/user_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';

import '../../data/repository/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit({required authRepository})
      : _authRepository = authRepository,
        super(SignupInitialState());

  signUpUsers(Map<String,dynamic> body) async {
    emit(SignupLoadingState());
    final result = await _authRepository.signup(body);
    result.fold(
      (failure) {
        var errorState = SignupErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(SignupLoadedState(user: value));
      },
    );
  }
}
