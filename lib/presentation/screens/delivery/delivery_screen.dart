import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/address_model.dart';
import 'package:multi/data/models/delivery_types.dart';
import 'package:multi/logic/cubit/delivery_types_cubit.dart';
import 'package:multi/logic/cubit/home_cubit.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/cubit/splash_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:collection/collection.dart';
import 'widgets/delivery_widgets.dart';
import 'package:geocoding/geocoding.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final List<String> deliveryTypes = [
    'Electronics',
    'Bags',
    'Documents',
    'Other'
  ];
  DeliveryTypesModel? selectedDeliveryType;

  int? pickupLocationId, destinationLocationId;

  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final customer = context.read<SigninCubit>().customerInfo!;
    senderNameController.text =
        '${customer.firstName} ${customer.middleName} ${customer.lastName}';
    senderPhoneController.text = customer.mobile;
    context.read<DeliveryTypesCubit>().getDeliveryTypes();
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
    final splashCubit = context.read<SplashCubit>();
    final placeMark = context.read<HomeCubit>().userPlaceMark;
    final addresses = splashCubit.systemAddreses;

    final village = _extractVillages(placeMark, addresses);
    final destinationOptions =
        village?.where((v) => v.id != pickupLocationId).toList() ?? [];

    final pickup = village?.firstWhereOrNull((v) => v.id == pickupLocationId);
    final destination =
        village?.firstWhereOrNull((v) => v.id == destinationLocationId);

    final isFormValid = pickupLocationId != null &&
        destinationLocationId != null &&
        senderNameController.text.isNotEmpty &&
        senderPhoneController.text.isNotEmpty &&
        receiverNameController.text.isNotEmpty &&
        receiverPhoneController.text.isNotEmpty &&
        selectedDeliveryType != null;

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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SenderSection(
                senderNameController: senderNameController,
                senderPhoneController: senderPhoneController,
                pickupLocationId: pickupLocationId,
                locations: village ?? [],
                onPickupChanged: (value) {
                  setState(() {
                    pickupLocationId = value;
                    if (destinationLocationId == value)
                      destinationLocationId = null;
                  });
                },
              ),
              _buildDivider(Colors.blue.shade100),
              const SizedBox(height: 24),
              ReceiverSection(
                receiverNameController: receiverNameController,
                receiverPhoneController: receiverPhoneController,
                destinationLocationId: destinationLocationId,
                destinationOptions: destinationOptions,
                onDestinationChanged: (value) =>
                    setState(() => destinationLocationId = value),
              ),
              _buildDivider(Colors.green.shade100),
              const SizedBox(height: 24),
              BlocBuilder<DeliveryTypesCubit, DeliveryTypesState>(
                builder: (context, state) {   
                  if (state is DeliveryTypesError) {
                    return Text(state.message);
                  }
                  if (state is DeliveryTypesLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is DeliveryTypesLoaded) {
                    return DeliveryTypeSection(
                    selectedDeliveryType: selectedDeliveryType,
                    deliveryTypes: state.deliverytypes,
                    onTypeChanged: (value) =>
                        setState(() => selectedDeliveryType = value),
                  );
                  }
                  return Container();
                },
              ),
              if (pickup != null &&
                  destination != null &&
                  selectedDeliveryType != null)
                RouteSummarySection(
                  senderName: senderNameController.text,
                  senderPhone: senderPhoneController.text,
                  receiverName: receiverNameController.text,
                  receiverPhone: receiverPhoneController.text,
                  pickupName: pickup.name,
                  destinationName: destination.name,
                  deliveryType: selectedDeliveryType!.name,
                ),
              const SizedBox(height: 16),
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle, size: 26),
                  label: const Text('Submit'),
                  onPressed: isFormValid
                      ? () => _showSuccessDialog(context, pickup!, destination!)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Village>? _extractVillages(
      Placemark? placeMark, List<Country>? addresses) {
    final country =
        addresses?.firstWhereOrNull((co) => co.name == placeMark?.country);
    final region = country?.regions
        ?.firstWhereOrNull((r) => r.name == placeMark?.administrativeArea);
    final city = region?.cities
        ?.firstWhereOrNull((c) => c.name == placeMark?.subAdministrativeArea);
    return city?.villages;
  }

  Widget _buildDivider(Color color) => Center(
        child: Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
        ),
      );

  void _showSuccessDialog(
      BuildContext context, Village pickup, Village destination) {
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
              const Text('Success!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(height: 10),
              Text(
                'Delivery from ${pickup.name} to ${destination.name} submitted!\n'
                'Sender: ${senderNameController.text} (${senderPhoneController.text})\n'
                'Receiver: ${receiverNameController.text} (${receiverPhoneController.text})\n'
                'Delivery Type: $selectedDeliveryType',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              const SpinKitThreeBounce(color: Colors.blueAccent, size: 24),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
