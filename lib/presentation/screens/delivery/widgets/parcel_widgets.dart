import 'package:flutter/material.dart';
import 'package:multi/data/models/address_model.dart';
import 'package:multi/data/models/parcel_types.dart';
import 'package:multi/presentation/widgets/custom_dropdown.dart';
import 'package:multi/presentation/widgets/custom_textfield.dart';

class SenderSection extends StatelessWidget {
  final TextEditingController senderNameController;
  final TextEditingController senderPhoneController;
  final int? pickupLocationId;
  final List<Village> locations;
  final void Function(int?) onPickupChanged;

  const SenderSection({
    super.key,
    required this.senderNameController,
    required this.senderPhoneController,
    required this.pickupLocationId,
    required this.locations,
    required this.onPickupChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade200,
                child: const Icon(Icons.send, color: Colors.white),
              ),
              const SizedBox(width: 14),
              const Text(
                'Sender Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: senderNameController,
            titleText: 'Sender Name',
            inputType: TextInputType.text,
            showTitle: true,
           
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: senderPhoneController,
            titleText: 'Sender Phone',
            inputType: TextInputType.phone,
            showTitle: true,
           
          ),
          const SizedBox(height: 14),
          CustomDropdown<int>(
            showTitle: true,
            label: 'Pickup Location',
            hintText: 'Pickup Location',
            value: pickupLocationId,
            onChanged: onPickupChanged,
            items: locations.map((loc) {
              return DropdownMenuItem<int>(
                value: loc.id,
                child: Text(loc.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ReceiverSection extends StatelessWidget {
  final TextEditingController receiverNameController;
  final TextEditingController receiverPhoneController;
  final int? destinationLocationId;
  final List<Village> destinationOptions;
  final void Function(int?) onDestinationChanged;

  const ReceiverSection({
    super.key,
    required this.receiverNameController,
    required this.receiverPhoneController,
    required this.destinationLocationId,
    required this.destinationOptions,
    required this.onDestinationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.shade200,
                child: const Icon(Icons.person_pin_circle, color: Colors.white),
              ),
              const SizedBox(width: 14),
              const Text(
                'Receiver Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomTextField(
            controller: receiverNameController,
            titleText: 'Receiver Name',
            showTitle: true,

          ),
          const SizedBox(height: 14),
          CustomTextField(
            showTitle: true,
            controller: receiverPhoneController,
            inputType: TextInputType.phone,
            titleText: 'Receiver Phone',

            
          ),
          const SizedBox(height: 14),
          CustomDropdown<int>(
            label: 'Destination Location',
            showTitle: true,
            hintText: 'Destination Location',
            value: destinationLocationId,
            onChanged: onDestinationChanged,
            items: destinationOptions.map((loc) {
              return DropdownMenuItem<int>(
                value: loc.id,
                child: Text(loc.name),
              );
            }).toList(),
          ),
        ],

      ),
    );
  }
}

class ParcelTypeSection extends StatelessWidget {
  final ParcelTypesModel? selectedParcelType;
  final List<ParcelTypesModel> parcelTypes;
  final void Function(ParcelTypesModel?) onTypeChanged;

  const ParcelTypeSection({
    super.key,
    required this.selectedParcelType,
    required this.parcelTypes,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange.shade200,
                child: const Icon(Icons.category, color: Colors.white),
              ),
              const SizedBox(width: 14),
              const Text(
                'Parcel Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomDropdown<ParcelTypesModel>(
            value: selectedParcelType,
            label: 'Parcel Type',
            hintText: 'Parcel Type',
            items: parcelTypes.map((type) => DropdownMenuItem<ParcelTypesModel>(
              value: type,
              child: Text(type.name),
            )).toList(),
            onChanged: onTypeChanged,
          ),
        ],
      ),
    );
  }
}

class RouteSummarySection extends StatelessWidget {
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String pickupName;
  final String destinationName;
  final String parcelType;

  const RouteSummarySection({
    super.key,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.pickupName,
    required this.destinationName,
    required this.parcelType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.route, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Route Summary', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Sender: $senderName ($senderPhone)\n'
                  'Receiver: $receiverName ($receiverPhone)\n'
                  'Pickup: $pickupName\nDestination: $destinationName\n'
                  'Parcel Type: $parcelType',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 