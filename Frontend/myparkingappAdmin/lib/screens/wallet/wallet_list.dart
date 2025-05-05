// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, file_names, unused_element

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_bloc.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_event.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_state.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/transaction/components/transaction_list.dart';
import 'package:myparkingappadmin/screens/wallet/wallet_detail.dart';
// Màn hình danh sách giao dịch của ví

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

class WalletList extends StatefulWidget {
  final String customerId;

  const WalletList({super.key, required this.customerId});

  @override
  _WalletListState createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  bool isDetail = false;
  WalletResponse? selectWallet;

  Set<String> objectColumnNameOfWallet = HashSet.from([
    "WalletName",
    "Type Money",
    "TransactionList",
    "Detail",
  ]);

  List<WalletResponse> wallets = [];

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(GetWalletByCustomerEvent(widget.customerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
        title: Text(AppLocalizations.of(context).translate("Wallet List")),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context
                  .read<WalletBloc>()
                  .add(GetWalletByCustomerEvent(widget.customerId));
            },
          ),
        ],
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WalletLoadedState) {
            wallets = state.walletResponse;
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
                            AppLocalizations.of(context).translate("Wallets"),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(height: defaultPadding),
                          wallets.isEmpty
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
                SizedBox(width: 10),
                isDetail
                    ? Expanded(
                        flex: 1,
                        child: WalletDetail(
                          object: selectWallet!,
                          onEdit: () {
                            setState(() {
                              isDetail = false;
                            });
                          },
                        ),
                      )
                    : SizedBox(width: 0),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {
          if (state is WalletSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess);
          } else if (state is WalletErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        },
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 16.0,
        columns: objectColumnNameOfWallet
            .map((name) => DataColumn(
                  label: Text(AppLocalizations.of(context).translate(name),
                      overflow: TextOverflow.ellipsis, maxLines: 1),
                ))
            .toList(),
        rows: wallets.map((wallet) {
          return _buildDataRow(wallet, context);
        }).toList(),
      ),
    );
  }

  DataRow _buildDataRow(WalletResponse wallet, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(wallet.name)),
        DataCell(Text(wallet.currency)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.list, color: Colors.blue),
            onPressed: () {
              print(wallet.walletId);
              setState(() {
                isDetail = true;
                selectWallet = wallet;
              });
              _showTransactionListDialog(context, wallet);
            },
          ),
        ),
        DataCell(
          IconButton(
              icon: const Icon(Icons.details, color: Colors.green),
              onPressed: () => {
                    print(wallet.walletId),
                    setState(() {
                      isDetail = true;
                      selectWallet = wallet;
                    })
                  }),
        ),
      ],
    );
  }

  void _showTransactionListDialog(BuildContext context, WalletResponse wallet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height / 1.2,
            width: Get.width / 1.2,
            child: TransactionList(
              walletId: wallet.walletId,
            ),
          ),
          // Màn hình danh sách giao dịch của ví
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
