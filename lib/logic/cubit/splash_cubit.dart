import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/address_model.dart';
import 'package:multi/data/repository/auth_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository _authRepository;

  SplashCubit({required authRepository}) : _authRepository = authRepository, super(SplashInitial()) {
    getAddress();
  }

  List<Country>? systemAddreses; 

  getAddress() async {
    try {
      emit(SplashLoading());
      final result = await _authRepository.getAddress();
    result.fold(
      (failure) {
        var errorState = SplashError(
            error:  failure.message);
        emit(errorState);
      },
      (value) {
        systemAddreses = value;
        emit(SplashLoaded(addresses: value));
      },
    );

    }catch (e) {
      emit(SplashError(error: 'Failed to fetch address ${e.toString()}'));
    }
  }
}
