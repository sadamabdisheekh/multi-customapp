import 'package:geolocator/geolocator.dart';

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
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
      throw const LocationException(3, 
        'Location permissions permanently denied. Enable in app settings.');
    }
  }

  /// Gets current device position
  static Future<Position> getCurrentLocation() async {
    await _checkPermissions();
    return await Geolocator.getCurrentPosition();
  }

  /// Stream of position updates
  static Stream<Position> get locationUpdates {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: _highAccuracy,
        distanceFilter: _distanceFilter,
      ),
    );
  }

  /// Stream of service status updates
  static Stream<ServiceStatus> get serviceStatusUpdates {
    return Geolocator.getServiceStatusStream();
  }
}