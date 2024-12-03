import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/user_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/auth_repository.dart';

import '../../data/providers/error/failure.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository _authRepository;

  UserModel? _user;
  bool get isLogedIn => _user != null;

  UserModel? get userInfo => _user;
  set user(UserModel userData) => _user = userData;

  SigninCubit({required authRepository})
      : _authRepository = authRepository,
        super(SigninInitialState()) {
    getCashedUser();
  }

  getCashedUser() {
    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
      },
    );
  }

  login(Map<String, dynamic> body) async {
    emit(SigninLoadingState());

    final result = await _authRepository.login(body);
    result.fold(
      (failure) {
        var errorState = SigninErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (user) {
        _user = user; 
        emit(SigninLoadedState(user: user));
      },
    );
  }

  Future<void> logOut() async {
    emit( SigninStateLogoutLoading());

    final result = await _authRepository.logOut();

    result.fold(
      (Failure failure) {
        if (failure.statusCode == 500) {
          const loadedData = SigninStateLogOut('logout success', 200);
          emit(loadedData);
        } else {
          final error =
              SigninStateLogOut(failure.message, failure.statusCode);
          emit( error);
        }
      },
      (String success) {
        _user = null;
        final loadedData = SigninStateLogOut(success, 200);
        emit(loadedData);
      },
    );
  }
}
