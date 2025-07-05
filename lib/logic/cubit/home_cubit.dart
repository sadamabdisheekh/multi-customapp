import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi/data/models/modules_model.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit({required homeRepository})
      : _homeRepository = homeRepository,
        super(HomeStateInitial()) {
    loadHomeData();
  }

  Placemark? userPlaceMark;
  Position? position;

  loadHomeData() async {
    emit(HomeLoadingState());
    final result = await _homeRepository.loadHomeData();
    result.fold(
      (failure) {
        var errorState = HomeErrorState(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(HomeLoadedState(response: value));
      },
    );
  }
}
