
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeStateInitial()) {
    loadHomeData();
  }

  loadHomeData() async {
    emit(HomeLoadingState());
  }
}
