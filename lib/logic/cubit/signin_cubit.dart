import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi/constants/enum.dart';
import 'package:multi/data/providers/error/custom_error.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninState.initial());
}
