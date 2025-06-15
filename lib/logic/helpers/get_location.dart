import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;

  /// Callbacks
  final void Function(Position position) onLocationUpdate;
  final void Function(String error) onError;
  final void Function(bool isServiceEnabled) onServiceStatusChanged;

  LocationService({
    required this.onLocationUpdate,
    required this.onError,
    required this.onServiceStatusChanged,
  });

  /// Start listening to location and service status
  Future<void> initialize() async {
    try {
      await _ensurePermissionAndService();

      // Start listening to position
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen(onLocationUpdate);

      // Start listening to service status changes
      _serviceStatusSubscription =
          Geolocator.getServiceStatusStream().listen((status) {
        final isEnabled = status == ServiceStatus.enabled;
        onServiceStatusChanged(isEnabled);

        if (!isEnabled) {
          onError('Location services have been disabled.');
        }
      });
    } catch (e) {
      onError(e.toString());

      // Optionally prompt the user
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
      }
    }
  }

  /// Stop all streams
  void dispose() {
    _positionSubscription?.cancel();
    _serviceStatusSubscription?.cancel();
  }

  /// Check and request necessary permissions and service state
  Future<void> _ensurePermissionAndService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }
  }
}
