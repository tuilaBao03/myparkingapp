// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

import '../../../constants.dart';
import '../../../data/dto/response/transaction_response.dart';

class TransactionDetail extends StatefulWidget {
  final TransactionResponse object;
  final VoidCallback onEdit;

  const TransactionDetail({
    super.key,
    required this.object,
    required this.onEdit,
  });

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  late final TextEditingController transactionIdController;
  late final TextEditingController currentBalanceController;
  late final TextEditingController descriptionController;
  late final TextEditingController typeController;
  final TextEditingController statusController = TextEditingController(text: "SUCCESS");
  late final TextEditingController walletIdController;
  late final TextEditingController dateController;

  @override
  @override
void initState() {
  super.initState();
  transactionIdController = TextEditingController();
  currentBalanceController = TextEditingController();
  descriptionController = TextEditingController();
  typeController = TextEditingController();
  walletIdController = TextEditingController();
  dateController = TextEditingController();

  _initializeFields();
}

void _initializeFields() {
  transactionIdController.text = widget.object.transactionId;
  currentBalanceController.text = widget.object.currentBalance.toString();
  descriptionController.text = widget.object.description;
  typeController.text = widget.object.type.toString().split('.').last;
  walletIdController.text = widget.object.walletId;
  dateController.text = widget.object.createAt.toString();
}

  @override
void didUpdateWidget(covariant TransactionDetail  oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.object != oldWidget.object) {
    _initializeFields(); // cập nhật lại controller khi user thay đổi
  }
}

  @override
  void dispose() {
    transactionIdController.dispose();
    currentBalanceController.dispose();
    descriptionController.dispose();
    typeController.dispose();
    statusController.dispose();
    walletIdController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
        title: Text("${widget.object.transactionId} / ${AppLocalizations.of(context).translate("Transaction Detail")}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              widget.onEdit(); // Call the callback to close the detail view
              // Refresh action can be added here if needed
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
                editController: transactionIdController,
                title: "Transaction ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: currentBalanceController,
                title: "Current Balance",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: descriptionController,
                title: "Description",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: typeController,
                title: "Transaction Type",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: statusController,
                title: "Transaction Status",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: walletIdController,
                title: "Wallet ID",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(
                editController: dateController,
                title: "Date",
                isEdit: false,
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
