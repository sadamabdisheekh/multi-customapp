import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  signUpUsers() {
    emit(SignupLoadingState());
  }
}
