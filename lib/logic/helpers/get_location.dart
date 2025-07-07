import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationException implements Exception {
  final int code;
  final String message;

  const LocationException(this.code, this.message);

  @override
  String toString() => 'LocationException: $message (code: $code)';
}

class LocationService {
  static const _highAccuracy = LocationAccuracy.high;
  static const _distanceFilter = 100; // meters

  /// Checks and requests location permissions
  static Future<void> _checkPermissions() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(1, 'Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException(2, 'Location permissions denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
        3,
        'Location permissions permanently denied. Enable in app settings.',
      );
    }
  }

  /// Gets current device position
  static Future<Position> getCurrentLocation() async {
    await _checkPermissions();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: _highAccuracy,
    );
  }

  /// Gets address from lat/lng
  static Future<Placemark?> getAddressFromLatLng(
      double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      debugPrint('Error getting address: $e');
      return null;
    }
  }

  /// Stream of continuous location updates
  static Stream<Position> get locationUpdates {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: _highAccuracy,
        distanceFilter: _distanceFilter,
      ),
    );
  }

  /// Stream of service status updates (on/off)
  static Stream<ServiceStatus> get locationServiceChange {
    return Geolocator.getServiceStatusStream();
  }

  /// Check if permissions and service are enabled
  static Future<bool> isLocationReady() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();

    return serviceEnabled &&
        (permission == LocationPermission.always ||
         permission == LocationPermission.whileInUse);
  }
}
