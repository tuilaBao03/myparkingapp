// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';

class InvoiceDetail extends StatefulWidget {
  final InvoiceResponse object;

  const InvoiceDetail({
    super.key,
    required this.object,
  });

  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  bool isEdit = false;
  late DiscountType selectedType;

  late TextEditingController _invoiceIdController;
  late TextEditingController _totalAmountController;
  late TextEditingController _statusController;
  late TextEditingController _descriptionController;
  late TextEditingController _vehicleController;
  late TextEditingController _monthlyTicketIdController;
  late TextEditingController _updateAtController;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  @override
  void didUpdateWidget(covariant InvoiceDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.object != widget.object) {
      _initializeFields();
    }
  }

  void _initializeFields() {
    _invoiceIdController =
        TextEditingController(text: widget.object.invoiceId);
    _totalAmountController =
        TextEditingController(text: widget.object.totalAmount.toString());
    _statusController =
        TextEditingController(text: widget.object.status.name);
    _descriptionController =
        TextEditingController(text: widget.object.description);
    _vehicleController =
        TextEditingController(text: widget.object.vehicle);
    _monthlyTicketIdController = TextEditingController(
        text: widget.object.monthlyTicketId.isEmpty ?
            'No Monthly Ticket' : "Monthly Ticket");
    _updateAtController =
        TextEditingController(text: widget.object.updateAt.toIso8601String());
    _descriptionController =
        TextEditingController(text: widget.object.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
        title: Text("${widget.object.invoiceId}/${AppLocalizations.of(context).translate("Invoice Detail")}"),
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
            children: [
              TextFieldCustom(
                  editController: _invoiceIdController,
                  title: "Invoice ID",
                  isEdit: false),
              TextFieldCustom(
                  editController: _vehicleController,
                  title: "Vehicle Number",
                  isEdit: false),
              TextFieldCustom(
                  editController: _statusController,
                  title: "Status",
                  isEdit: false),
              TextFieldCustom(
                  editController: _monthlyTicketIdController,
                  title: "Monthly Ticket ID",
                  isEdit: false),
              TextFieldCustom(
                  editController: _totalAmountController,
                  title: "Total Amount",
                  isEdit: isEdit),
              TextFieldCustom(
                title: 'Discount Type',
                isEdit: isEdit, editController: _descriptionController),
              TextFieldCustom(
                  editController: _updateAtController,
                  title: "Updated At",
                  isEdit: false),
              TextFieldCustom(
                  editController: _descriptionController,
                  title: "Description",
                  isEdit: isEdit),

            ],
          ),
        ),
      ),
    );
  }
}
