
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/address_model.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/cubit/splash_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'widgets/delivery_widgets.dart';
import 'package:collection/collection.dart';

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

  final List<String> deliveryTypes = [
    'Electronics',
    'Bags',
    'Documents',
    'Other',
  ];
  String? selectedDeliveryType;

  int? pickupLocationId;
  int? destinationLocationId;

  // New: Controllers for sender/receiver info
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderPhoneController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverPhoneController = TextEditingController();

@override
void initState() {
  super.initState();
    final customer = context.read<SigninCubit>().customerInfo!;
    final customerName = '${customer.firstName} ${customer.middleName} ${customer.lastName}';
    senderNameController.text = customerName;
    senderPhoneController.text = customer.mobile;
}

@override
void dispose() {
  senderNameController.dispose();
  senderPhoneController.dispose();
  receiverNameController.dispose();
  receiverPhoneController.dispose();
  super.dispose();
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
    final homeCubit = context.read<HomeCubit>();
final splashCubit = context.read<SplashCubit>();
final placeMark = homeCubit.userPlaceMark;
final addresses = splashCubit.systemAddreses;

var userAddress;
Country? country;
Region? region;
City? city;


if (placeMark != null && addresses?.isNotEmpty == true) {
  country = addresses?.firstWhereOrNull((co) => co.name == placeMark.country);
  region = country?.regions?.firstWhereOrNull((r) => r.name == placeMark.administrativeArea);
  city = region?.cities?.firstWhereOrNull((c) => c.name == placeMark.subAdministrativeArea);

}

  





    return Scaffold(
      appBar: AppBar(title: const Text('Delivery')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFF), Color(0xFFE3ECFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
             
                // Sender Section
                SenderSection(
                  senderNameController: senderNameController,
                  senderPhoneController: senderPhoneController,
                  pickupLocationId: pickupLocationId,
                  locations: locations,
                  onPickupChanged: (value) {
                    setState(() {
                      pickupLocationId = value;
                      if (destinationLocationId == value) {
                        destinationLocationId = null;
                      }
                    });
                  },
                ),
                // Divider
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Receiver Section
                ReceiverSection(
                  receiverNameController: receiverNameController,
                  receiverPhoneController: receiverPhoneController,
                  destinationLocationId: destinationLocationId,
                  destinationOptions: destinationOptions,
                  onDestinationChanged: (value) => setState(() => destinationLocationId = value),
                ),
                // Divider
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Delivery Type Section
                DeliveryTypeSection(
                  selectedDeliveryType: selectedDeliveryType,
                  deliveryTypes: deliveryTypes,
                  onTypeChanged: (value) => setState(() => selectedDeliveryType = value),
                ),
                // Route Summary
                if (pickup != null && destination != null && selectedDeliveryType != null)
                  RouteSummarySection(
                    senderName: senderNameController.text,
                    senderPhone: senderPhoneController.text,
                    receiverName: receiverNameController.text,
                    receiverPhone: receiverPhoneController.text,
                    pickupName: pickup['name'],
                    destinationName: destination['name'],
                    deliveryType: selectedDeliveryType!,
                  ),
                // Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle, size: 26),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        elevation: 4,
                      ),
                      label: const Text('Submit'),
                      onPressed: (pickupLocationId == null || destinationLocationId == null ||
                          senderNameController.text.isEmpty || senderPhoneController.text.isEmpty ||
                          receiverNameController.text.isEmpty || receiverPhoneController.text.isEmpty ||
                          selectedDeliveryType == null)
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctx) => Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.green, size: 60),
                                        const SizedBox(height: 18),
                                        const Text('Success!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Delivery from ${pickup!['name']} to ${destination!['name']} submitted!\n'
                                          'Sender: ${senderNameController.text} (${senderPhoneController.text})\n'
                                          'Receiver: ${receiverNameController.text} (${receiverPhoneController.text})\n'
                                          'Delivery Type: $selectedDeliveryType',
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 18),
                                        SpinKitThreeBounce(
                                          color: Colors.blueAccent,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          onPressed: () => Navigator.of(ctx).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                    ),
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}


