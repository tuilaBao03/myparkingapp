// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';



import '../../../constants.dart';



class ParkingSlotDetail extends StatefulWidget {
  final ParkingSlotResponse object;
  final VoidCallback onEdit;
  
  const ParkingSlotDetail({
    super.key,
    required this.object, required this.onEdit,
  });

  @override
  State<ParkingSlotDetail> createState() => _ParkingSlotDetailState();
}

class _ParkingSlotDetailState extends State<ParkingSlotDetail> {
  bool isEdit = false; // ✅ Đặt ở đây để không bị reset mỗi lần build lại

  late final TextEditingController nameController;
  late final TextEditingController vehicleController;
  late final TextEditingController pricePerHourController;
  late final TextEditingController pricePerMonthController;
  late final TextEditingController slotStatusController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.object.slotName);
    vehicleController = TextEditingController(text: widget.object.vehicleType);
    pricePerHourController =
        TextEditingController(text: widget.object.pricePerHour.toString());
    pricePerMonthController =
        TextEditingController(text: widget.object.pricePerMonth.toString());
    slotStatusController =
        TextEditingController(text: widget.object.slotStatus.name.toUpperCase());
  }

  @override
  void dispose() {
    nameController.dispose();
    vehicleController.dispose();
    pricePerHourController.dispose();
    pricePerMonthController.dispose();
    slotStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
        title:
            Text("${widget.object.slotName} / ${AppLocalizations.of(context).translate("Parking Lot Detail")}"),
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEdit = !isEdit; // ✅ Toggle giữa chế độ xem và chỉnh sửa
              });
            },
          ),
          
        ],
      ),
      body: Container(
        height: Get.height,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldCustom(
                  editController: nameController,
                  title: "Slot Name",
                  isEdit: false),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                  editController: vehicleController,
                  title: "Vehicle Type",
                  isEdit: false),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                  editController: pricePerHourController,
                  title: "Price Per Hour",
                  isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                  editController: pricePerMonthController,
                  title: "Price Per Month",
                  isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                  editController: slotStatusController,
                  title: "Slot Status",
                  isEdit: false),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
