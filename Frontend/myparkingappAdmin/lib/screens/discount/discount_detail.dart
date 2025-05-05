// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/bloc/discount/discount_bloc.dart';
import 'package:myparkingappadmin/bloc/discount/discount_event.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_discount_request.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';

class DiscountDetail extends StatefulWidget {
  final DiscountResponse object;
  final VoidCallback onEdit;

  const DiscountDetail({
    super.key,
    required this.object, required this.onEdit,
  });

  @override
  State<DiscountDetail> createState() => _DiscountDetailState();
}

class _DiscountDetailState extends State<DiscountDetail> {
  bool isEdit = false;
  late DiscountType selectedType;

  late TextEditingController _discountCodeController;
  late TextEditingController _discountValueController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  // Nếu muốn cập nhật lại khi widget.object thay đổi (ví dụ khi dùng Hero hoặc pushNamed lại)
  @override
  void didUpdateWidget(covariant DiscountDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.object != widget.object) {
      _initializeFields();
    }
  }

  void _initializeFields() {
    _discountCodeController =
        TextEditingController(text: widget.object.discountCode);
    _discountValueController =
        TextEditingController(text: widget.object.discountValue.toString());
    _descriptionController =
        TextEditingController(text: widget.object.description);
    selectedType = widget.object.discountType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.object.discountCode} / ${AppLocalizations.of(context).translate("Discount Detail")}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.onEdit,
          ),

          isEdit
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final request = UpdateDiscountResquest(
                      discountType: selectedType,
                      discountValue:
                          double.tryParse(_discountValueController.text) ?? 0,
                      description: _descriptionController.text,
                    );
                    context.read<DiscountBloc>().add(
                        UpdateDiscountEvent(request, widget.object.discountId));
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEdit = true;
                    });
                  },
                )
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
                isEdit: isEdit),
            SizedBox(height: defaultPadding),
            TextFieldCustom2(
              title: 'Discount type',
              isEdit: isEdit,
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
            TextFieldCustom(
                editController: _discountValueController,
                title: "Discount value",
                isEdit: isEdit),
            SizedBox(height: defaultPadding),   
            Expanded(
              child: TextFieldCustom(
                  editController: _descriptionController,
                  title: "Description",
                  isEdit: isEdit),
            )
          ],
        ),
      ),
    );
  }
}
