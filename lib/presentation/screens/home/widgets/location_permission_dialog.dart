import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi/logic/helpers/get_location.dart';

class LocationPermissionDialog extends StatelessWidget {
  final LocationException status;
  final VoidCallback onRetry;

  const LocationPermissionDialog({
    Key? key,
    required this.status,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: theme.colorScheme.background,
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on_rounded,
                size: 40,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Location Required",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getErrorMessage(status),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                   final serviceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  final permission = await Geolocator.checkPermission();

                  if (!serviceEnabled) {
                    await Geolocator.openLocationSettings();
                  } else if (permission == LocationPermission.deniedForever) {
                    await Geolocator.openAppSettings();
                  } else {
                    await Geolocator.openLocationSettings();
                  }

                  onRetry();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Enable Location",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _getErrorMessage(LocationException status) {
    switch (status.code) {
      case 1:
        return "Location services are turned off. Please enable them to continue.";
      case 2:
        return "Location permission is denied. Allow access to continue.";
      case 3:
        return "Permission permanently denied. Please enable it from app settings.";
      default:
        return "Unable to access your location. Please check settings.";
    }
  }
}
