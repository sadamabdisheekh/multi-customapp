import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi/logic/helpers/get_location.dart';
import 'package:multi/presentation/widgets/custom_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final List<Map<String, dynamic>> locations = [
    {"id": 1, "name": "Bakara Market"},
    {"id": 2, "name": "KM4 Junction"},
    {"id": 3, "name": "Wadajir District"},
    {"id": 4, "name": "Hodan District"},
  ];

  int? pickupLocationId;
  int? destinationLocationId;

  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;
  Position? _currentPosition;
  ServiceStatus? _currentServiceStatus;
  String? _locationError;

void initState() {
  super.initState();
  _initLocationServices();
}

Future<void> _initLocationServices() async {
  try {
    final position = await LocationService.getCurrentLocation();
    setState(() => _currentPosition = position);
    _setupLocationListeners();
  } catch (e) {
    setState(() => _locationError = e.toString());
  }
}

void _setupLocationListeners() {
  _positionSubscription = LocationService.locationUpdates.listen(
    (position) => setState(() => _currentPosition = position),
    onError: (e) => setState(() => _locationError = e.toString()),
  );

  _serviceStatusSubscription = LocationService.serviceStatusUpdates.listen(
    (status) => setState(() => _currentServiceStatus = status),
  );
}

  Future<void> _showLocationServiceDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Location Required'),
        content: const Text(
            'Location services are disabled. Please enable them to proceed.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destinationOptions =
        locations.where((loc) => loc['id'] != pickupLocationId).toList();
    final pickup = pickupLocationId != null
        ? locations.firstWhere((l) => l['id'] == pickupLocationId)
        : null;
    final destination = destinationLocationId != null
        ? locations.firstWhere((l) => l['id'] == destinationLocationId)
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Delivery')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_locationError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Location Error: \\${_locationError}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_currentServiceStatus != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Service Status: \\${_currentServiceStatus}'),
              ),
            if (_currentPosition != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Current Position: \\${_currentPosition!.latitude}, \\${_currentPosition!.longitude}',
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final pos = await LocationService.getCurrentLocation();
                  setState(() {
                    _currentPosition = pos;
                    _locationError = null;
                  });
                } catch (e) {
                  setState(() {
                    _locationError = e.toString();
                  });
                }
              },
              child: const Text('Get Current Location Once'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pickup Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              label: 'Select pickup location',
              value: pickupLocationId,
              onChanged: (value) {
                setState(() {
                  pickupLocationId = value;
                  if (destinationLocationId == value) {
                    destinationLocationId = null;
                  }
                });
              },
              items: locations,
              icon: Icons.location_on,
            ),
            const SizedBox(height: 20),
            const Text(
              'Destination Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildDropdown(
              label: 'Select destination location',
              value: destinationLocationId,
              onChanged: (value) =>
                  setState(() => destinationLocationId = value),
              items: destinationOptions,
              icon: Icons.flag,
            ),
            const SizedBox(height: 24),
            if (pickup != null && destination != null)
              Card(
                color: Colors.blue.shade50,
                margin: const EdgeInsets.only(bottom: 20),
                child: ListTile(
                  leading: const Icon(Icons.route, color: Colors.blue),
                  title: Text('Route Summary'),
                  subtitle: Text(
                    'Pickup: \\${pickup['name']}\\nDestination: \\${destination['name']}',
                  ),
                ),
              ),
            CustomButton(
              buttonText: 'Submit',
              width: double.infinity,
              onPressed: (pickupLocationId == null || destinationLocationId == null)
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Success'),
                          content: Text(
                            'Delivery from \\${pickup!['name']} to \\${destination!['name']} submitted!',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required void Function(int?) onChanged,
    required List<Map<String, dynamic>> items,
    IconData? icon,
  }) {
    return DropdownButtonFormField<int>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      items: items.map((loc) {
        return DropdownMenuItem<int>(
          value: loc['id'],
          child: Text(loc['name']),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
