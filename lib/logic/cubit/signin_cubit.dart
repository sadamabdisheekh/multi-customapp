import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/customer_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/auth_repository.dart';

import '../../data/providers/error/failure.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository _authRepository;

  CustomerModel? _customer;
  bool get isLogedIn => _customer != null;

  CustomerModel? get customerInfo => _customer;
  set customer(CustomerModel customerData) => _customer = customerData;

  SigninCubit({required authRepository})
      : _authRepository = authRepository,
        super(SigninInitialState()) {
    getCashedUser();
  }

  getCashedUser() {
    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _customer = null,
      (r) {
        customer = r;
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
        _customer = user;
        emit(SigninLoadedState(user: user));
      },
    );
  }

  Future<void> logOut() async {
    emit(SigninStateLogoutLoading());

    final result = await _authRepository.logOut();

    result.fold(
      (Failure failure) {
        if (failure.statusCode == 500) {
          const loadedData = SigninStateLogOut('logout success', 200);
          emit(loadedData);
        } else {
          final error = SigninStateLogOut(failure.message, failure.statusCode);
          emit(error);
        }
      },
      (String success) {
        _customer = null;
        final loadedData = SigninStateLogOut(success, 200);
        emit(loadedData);
      },
    );
  }
}
