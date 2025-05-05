// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, file_names, unused_element
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_bloc.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_event.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_state.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/transaction/components/transaction_detail.dart';


import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

class TransactionList extends StatefulWidget {
  final String walletId;
  const TransactionList({super.key, required this.walletId});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool isDetail = false;
  TransactionResponse? transaction;
  TransactionType type = TransactionType.TOP_UP;

  Set<String> objectColumnNameOfTransaction = HashSet.from([
    "TranId",
    "Date",
    "CurrentDetail",
    "Detail",
  ]);

  List<TransactionResponse> transactions = [];

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(GetTransactionsByWalletEvent(widget.walletId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
          title: Text(
            "${widget.walletId} / ${AppLocalizations.of(context).translate("Transaction List")}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<TransactionBloc>().add(GetTransactionsByWalletEvent(widget.walletId));
              },
            ),
          ],
        ),
        body: BlocConsumer<TransactionBloc, TransactionState>(
            builder: (context, state) {
          if (state is TransactionLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TransactionLoadedState) {
            transactions = state.trans;
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate("Transactions"),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(height: defaultPadding),
                          transactions.isEmpty
                              ? Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                        "There is no matching information"),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              : _buildDataTable(context),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                isDetail
                    ? Expanded(
                        flex: 1,
                        child: TransactionDetail(object: transaction!, onEdit: () { setState(() {
                          isDetail = false;
                        }); },),
                      )
                    : SizedBox(
                        width: 0,
                      ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }, listener: (context, state) {
          if (state is TransactionSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess);
          } else if (state is TransactionErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        }));
  }

  Widget _buildDataTable(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 16.0,
        columns: objectColumnNameOfTransaction
            .map((name) => DataColumn(
                  label: Text(AppLocalizations.of(context).translate(name),
                      overflow: TextOverflow.ellipsis, maxLines: 1),
                ))
            .toList(),
        rows: transactions.map((transaction) {
          return _buildDataRow(transaction, context);
        }).toList(),
      ),
    );
  }

  DataRow _buildDataRow(TransactionResponse transaction, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(transaction.currentBalance.toString())),
        DataCell(Text(transaction.createAt.toString())),
        DataCell(Text(transaction.currentBalance.toString())),
        DataCell(Row(
          children: [
            Expanded(
              child: IconButton(
                  icon: const Icon(Icons.details, color: Colors.green),
                  onPressed: () => setState(() {
                        isDetail = true;
                        this.transaction = transaction;
                      })),
            ),
          ],
        )),
      ],
    );
  }
}
