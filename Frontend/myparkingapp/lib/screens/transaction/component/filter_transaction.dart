// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class FilterTransaction extends StatefulWidget {
  final WalletResponse wallet;
  final TransactionType type;

  final int page;
  final int size;

  const FilterTransaction({
    super.key,
    required this.type,
    required this.size,
    required this.wallet,
    required this.page,
  });

  @override
  State<FilterTransaction> createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  late TransactionType selectType;
  late DateTime startSelect;
  late DateTime endSelect;

  @override
  void initState() {
    super.initState();
    selectType = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền xám nhạt
        borderRadius: BorderRadius.circular(12), // Bo góc nhẹ
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Màu bóng nhẹ
            spreadRadius: 1, // Độ lan của bóng
            blurRadius: 8, // Độ mờ của bóng
            offset: Offset(2, 4), // Vị trí bóng đổ (x, y)
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = TransactionType.TOP_UP;
                    });
                  },
                  style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                    backgroundColor: selectType == TransactionType.TOP_UP
                        ? Colors.green
=======
                    backgroundColor: selectType == Transactions.TOP_UP
                        ? Colors.blue
>>>>>>> main
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("TOP_UP")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = TransactionType.PAYMENT;
                    });
                  },
                  style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                    backgroundColor: selectType == TransactionType.PAYMENT
                        ? Colors.green
=======
                    backgroundColor: selectType == Transactions.PAYMENT
                        ? Colors.blue
>>>>>>> main
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("PAYMENT")),
                ),
              ),

            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = TransactionType.DEPOSIT;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectType == TransactionType.DEPOSIT
                        ? Colors.green
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("deposit").toUpperCase()),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectType = TransactionType.RETURN_DEPOSIT;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectType == TransactionType.RETURN_DEPOSIT
                        ? Colors.green
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("re deposit").toUpperCase()),
                ),
              ),

            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TransactionBloc>().add(
                          LoadTransactionEvent(widget.wallet,selectType,widget.page,widget.size
                          ),
                        );
                  },
                  child: Text(AppLocalizations.of(context).translate("Filter")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<TransactionBloc>()
                        .add(LoadTransactionEvent(widget.wallet, TransactionType.PAYMENT, 1,10));
                  },
                  child: Text(AppLocalizations.of(context).translate("Empty")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
