// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/discount/discount_bloc.dart';
import 'package:myparkingappadmin/bloc/discount/discount_event.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/create_discount_request.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';

class AddDiscount extends StatefulWidget {
  final String parkingLotID;
  const AddDiscount({
    super.key,
    required this.parkingLotID
  });

  @override
  State<AddDiscount> createState() => _AddDiscountState();
}

class _AddDiscountState extends State<AddDiscount> {
  final TextEditingController _discountCodeController = TextEditingController();
  final TextEditingController _discountValueController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DiscountType selectedType = DiscountType.PERCENTAGE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Discount"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final CreateDiscountResquest request = CreateDiscountResquest(
                discountCode: _discountCodeController.text.trim(),
                discountType: selectedType,
                discountValue:
                    double.tryParse(_discountValueController.text) ?? 0,
                description: _descriptionController.text, parkingLotID: widget.parkingLotID,
              );
              context.read<DiscountBloc>().add(CreateDiscountEvent(request));
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
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            TextFieldCustom(
                editController: _discountCodeController,
                title: "Discount code",
                isEdit: true),
            SizedBox(height: defaultPadding),
            TextFieldCustom(
                editController: _discountValueController,
                title: "Discount Value",
                isEdit: true),
            SizedBox(height: defaultPadding),
            TextFieldCustom2(
              title: 'Discount type',
              isEdit: true,
              isDropdown: true,
              selectedValue: selectedType.name,
              dropdownItems: DiscountType.values.map((e) => e.name).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType =
                      DiscountType.values.firstWhere((e) => e.name == value);
                });
              },
            ),
            SizedBox(height: defaultPadding),
            Expanded(
              child: TextFieldCustom(
                editController: _descriptionController,
                title: "Description",
                isEdit: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
