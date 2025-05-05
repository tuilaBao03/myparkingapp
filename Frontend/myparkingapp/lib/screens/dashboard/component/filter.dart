// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class FilterTransactionDBoard extends StatefulWidget {
  final int size;
  final UserResponse userResponse;
  final List<TransactionResponse> tran;

  const FilterTransactionDBoard({
    super.key,
    required this.tran, required this.userResponse, required this.size,
  });

  @override
  State<FilterTransactionDBoard> createState() => _FilterTransactionDBoardState();
}

class _FilterTransactionDBoardState extends State<FilterTransactionDBoard> {
  TransactionType? selectType;
  DateTime? startSelect;
  DateTime? endSelect;
  // Hàm chọn ngày
Future<void> _pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startSelect : endSelect,
      firstDate: DateTime.now().subtract(const Duration(days: 365)), // Giới hạn 1 năm trước
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startSelect = picked;
        } else {
          endSelect = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).translate("From"), style: TextStyle(color:Colors.white, fontSize: 15),),
              TextButton(
                onPressed: () => _pickDate(context, true),
                child: Text("${startSelect?.toLocal()}".split(' ')[0], style: TextStyle(color:Colors.lightGreenAccent, fontSize: 15),),
              ),
              Text(AppLocalizations.of(context).translate("To"), style: TextStyle(color:Colors.white, fontSize: 15),),
              TextButton(
                onPressed: () => _pickDate(context, false),
                child: Text("${endSelect?.toLocal()}".split(' ')[0], style: TextStyle(color:Colors.lightGreenAccent, fontSize: 15),),
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
                      selectType = TransactionType.TOP_UP;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectType == TransactionType.TOP_UP
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("top_up").toUpperCase()),
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
                    backgroundColor: selectType == TransactionType.PAYMENT
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: Text(AppLocalizations.of(context).translate("payment").toUpperCase()),
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
                        ? Colors.blue
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
                        ? Colors.blue
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
                    context.read<TransactionBloc>().add(FilterTransactionByTimeEvent(selectType,startSelect,endSelect,widget.tran,widget.size));
                  },
                  child: Text(AppLocalizations.of(context).translate("Filter")),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TransactionBloc>().add(LoadAllTransactionByTimeEvent(widget.userResponse,widget.size));
                  },
                  child: Text(AppLocalizations.of(context).translate("Refresh")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
