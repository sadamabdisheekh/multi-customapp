import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi/logic/helpers/get_location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial()) {
    // getUserCurrentLocation();
  }

  Position? userCurrentLocationPossion;

  getUserCurrentLocation() async {
    emit(LocationLoading());
    UserLocation.getCurrentPosition().then((value) {
      userCurrentLocationPossion = value;
      emit(LocationLoaded(position: value));
    }).catchError((error) {
      emit(LocationError(code: 100, message: error.toString()));
    });
  }
}
