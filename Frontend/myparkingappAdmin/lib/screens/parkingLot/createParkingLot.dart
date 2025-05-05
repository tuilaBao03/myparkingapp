// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_event.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';
import 'package:myparkingappadmin/validation.dart';

class CreateParkingLotScreen extends StatefulWidget {
  final UserResponse user;
  const CreateParkingLotScreen({super.key, required this.user});

  @override
  State<CreateParkingLotScreen> createState() => _CreateParkingLotScreenState();
}

class _CreateParkingLotScreenState extends State<CreateParkingLotScreen> {
  final _formKey = GlobalKey<FormState>();
  final parkingLotNameController = TextEditingController();
  final addressController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final rateController = TextEditingController();
  final descriptionController = TextEditingController();
  final totalSlotController = TextEditingController();

  List<LocationInputSection> locationInputs = [LocationInputSection()];

  void addLocationInput() {
    setState(() {
      locationInputs.add(LocationInputSection());
    });
  }

  void submit() {

    if (_formKey.currentState!.validate()) {
    final request = CreateParkingLotRequest(
            parkingLotName: parkingLotNameController.text,
      address: addressController.text,
      latitude: double.tryParse(latitudeController.text) ?? 0,
      longitude: double.tryParse(longitudeController.text) ?? 0,
      rate: double.tryParse(rateController.text) ?? 0,
      description: descriptionController.text,
      userID: widget.user.userId,
      totalSlot: int.tryParse(totalSlotController.text) ?? 0,
      images: [], // Add logic for image upload
      locationConfigs: locationInputs.map((e) => e.toLocationConfig()).toList(),
    );

    print(request.toJson());
    context.read<ParkingLotBloc>().add(CreateParkingLotEvent(request)); // Gửi lên server
  } else {
    Get.snackbar(
      AppLocalizations.of(context).translate("Error"),
      AppLocalizations.of(context).translate("Please, enter full info"),
    );
  }// Or call your API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate("Create Parking Lot")),
      actions: [
        ElevatedButton(
                onPressed: submit,
                child: Text(AppLocalizations.of(context).translate("Submit")),
        ),
      ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldCustom(editController: parkingLotNameController, title: 'Parking Lot Name', isEdit: true),
              TextFieldCustom(editController: addressController, title: 'Address', isEdit: true),
              TextFieldCustom(editController: latitudeController, title: 'Latitude', isEdit: true),
              TextFieldCustom(editController: longitudeController, title: 'Longitude', isEdit: true),
              TextFieldCustom(editController: rateController, title: 'Rate', isEdit: true),
              TextFieldCustom(editController: descriptionController, title: 'Description', isEdit: true),
              TextFieldCustom(editController: totalSlotController, title: 'Total Slot (All Locations)', isEdit: true),
              const SizedBox(height: 20),
              const Divider(),
              const Text("Location Info", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 👉 scroll ngang
                  child: Row(
                    children: [
                      ...locationInputs.map((input) => input),
                      TextButton.icon(
                        onPressed: addLocationInput,
                        icon: const Icon(Icons.add),
                        label: Text(AppLocalizations.of(context).translate("Add Location")),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationInputSection extends StatefulWidget {

  final locationController = TextEditingController();
  final totalSlotController = TextEditingController();

  final Map<VehicleType, TextEditingController> numberOfSlotControllers = {
    VehicleType.MOTORCYCLE: TextEditingController(),
    VehicleType.CAR: TextEditingController(),
    VehicleType.BICYCLE: TextEditingController(),
  };

  final Map<VehicleType, TextEditingController> pricePerHourControllers = {
    VehicleType.MOTORCYCLE: TextEditingController(),
    VehicleType.CAR: TextEditingController(),
    VehicleType.BICYCLE: TextEditingController(),
  };

  final Map<VehicleType, TextEditingController> pricePerMonthControllers = {
    VehicleType.MOTORCYCLE: TextEditingController(),
    VehicleType.CAR: TextEditingController(),
    VehicleType.BICYCLE: TextEditingController(),
  };

  LocationConfig toLocationConfig() {
    return LocationConfig(
      location: locationController.text,
      totalSlot: int.tryParse(totalSlotController.text) ?? 0,
      vehicleSlotConfigs: VehicleType.values.map((type) {
        return VehicleSlotConfig(
          type: type,
          numberOfSlot: int.tryParse(numberOfSlotControllers[type]?.text ?? '') ?? 0,
          pricePerHour: double.tryParse(pricePerHourControllers[type]?.text ?? '') ?? 0,
          pricePerMonth: double.tryParse(pricePerMonthControllers[type]?.text ?? '') ?? 0,
        );
      }).toList(),
    );
  }

  @override
  State<LocationInputSection> createState() => _LocationInputSectionState();
}

class _LocationInputSectionState extends State<LocationInputSection> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width/4,
      width: Get.width/5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          TextFieldCustom(
            editController: widget.locationController,
            title: 'Location',
            isEdit: true,
            validator: (value) => Validator.requiredField(value, "Location"),
          ),
          TextFieldCustom(
            editController: widget.totalSlotController,
            title: 'Total Slot (Location)',
            isEdit: true,
            validator: (value) => Validator.requiredField(value, "Total Slot"),
          ),
          ...VehicleType.values.map((type) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(type.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldCustom(
                          title: "Number of Slot",
                          editController: widget.numberOfSlotControllers[type]!,
                          isEdit: true,
                          validator: (value) => Validator.requiredField(value, "Number of Slot"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFieldCustom(
                          title: "Price Per Hour",
                          editController: widget.pricePerHourControllers[type]!,
                          isEdit: true,
                          validator: (value) => Validator.requiredField(value, "Price Per Hour"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFieldCustom(
                          title: "Price Per Month",
                          editController: widget.pricePerMonthControllers[type]!,
                          isEdit: true,
                          validator: (value) => Validator.requiredField(value, "Price Per Month"),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
