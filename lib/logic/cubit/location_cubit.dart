import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/providers/error/location_error.dart';
import '../helpers/get_location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  StreamSubscription<Position>? positionSubscription;

  LocationCubit() : super(LocationInitial()) {
    // _initializeLocation();
  }

  void _initializeLocation() async {
    emit(LocationLoading());
    try {
      // final position = await UserLocation.getCurrentPosition();
      // await _updateLocation(position);
      // _listenToPositionChanges();
    } catch (error) {
      _handleLocationError(error);
    }
  }

  void _listenToPositionChanges() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best, // Highest accuracy
      distanceFilter: 10, // Trigger updates every 10 meters moved
    );
    positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) async {
        await _updateLocation(position);  // Update with each new position
      }, onError: (e) {
        _handleLocationError(e);
      }
    );
  }

  Future<void> _updateLocation(Position position) async {
    try {
      final address = await _getAddressFromLatLng(position.latitude, position.longitude);
      emit(LocationLoaded(location: address));  // Emit loaded state with new address
    } catch (e) {
      _handleLocationError(e);
    }
  }

  Future<String> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      print('latitude is $latitude and longitude is $longitude');
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
         String district = place.subAdministrativeArea ?? 'Unknown District';
      String country = place.country ?? 'Unknown Country';
      return '$district, $country, ${place.name}';
      }
      return "No address available";
    } catch (e) {
      return "Failed to get address";
    }
  }

  void _handleLocationError(dynamic error) {
    if (error is LocationServiceException) {
      emit(LocationError(code: error.code, message: error.message));
    } else {
      emit(const LocationError(code: 500, message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<void> close() {
    positionSubscription?.cancel();
    return super.close();
  }
}
