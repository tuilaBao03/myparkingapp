
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/invoice/bloc.dart';
import 'package:myparkingappadmin/bloc/invoice/event.dart';
import 'package:myparkingappadmin/bloc/invoice/state.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import '../../app/localization/app_localizations.dart';
import '../../constants.dart';

import 'invoice_detail.dart';

class InvoiceList extends StatefulWidget {
  final ParkingSlotResponse parkingSlot;

  const InvoiceList({
    super.key,
    required this.parkingSlot
  });

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List<InvoiceResponse> invoiceList = [];
  List<String> objectColumnName = [
    'InvoiceId',
    'Details',
  ];

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(
      GetInvoiceBySlotEvent(widget.parkingSlot.slotId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
        title: Text("${widget.parkingSlot.slotName} / ${AppLocalizations.of(context).translate("Invoice List")}"),
      ),
      body: BlocConsumer<InvoiceBloc,InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InvoiceLoadedState ) {
            invoiceList = state.invoiceList;
            return Container(
              height: Get.height,
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding),
                    invoiceList.isEmpty
                        ? Container(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Center(
                              child: Text(AppLocalizations.of(context)
                                  .translate("There is no matching information")),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              columnSpacing: defaultPadding,
                              columns: objectColumnName
                                  .map((name) => DataColumn(
                                        label: Text(
                                          AppLocalizations.of(context)
                                              .translate(name),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ))
                                  .toList(),
                              rows: List.generate(
                                invoiceList.length,
                                (index) => recentFileDataRow(
                                  invoiceList[index],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
          }
          return Center(
              child: CircularProgressIndicator(),
            ); // Handle other states
        },
        listener: (context, state) {
          if (state is InvoiceSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess);
          } else if (state is InvoiceErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        },
      ),
    );
  }

  DataRow recentFileDataRow(InvoiceResponse discountInfo) {
    return DataRow(
      cells: [
        DataCell(Text(discountInfo.invoiceId)),
        DataCell(
          IconButton(
            icon: Icon(Icons.details, color: Colors.green),
            onPressed: () => {
              _showDetailDialog(
                context,
                discountInfo,
              ),
            }
          ),
        ),
      ],
    );
  }
  void _showDetailDialog(BuildContext context, InvoiceResponse  discountInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).translate("Invoice Detail")),
        content: SizedBox(
            height: Get.height/1.2,
            width: Get.width/2,
            child: InvoiceDetail(object: discountInfo),
          ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context).translate("Close")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

}
}


