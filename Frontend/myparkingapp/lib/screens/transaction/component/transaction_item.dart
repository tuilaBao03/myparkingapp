// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';


import '../../../constants.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key, required this.tran,
  });
  final TransactionResponse tran;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppDialog.showDetailTransaction(context, tran);
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusOfItems(transactionType: tran.type,),
              const SizedBox(width: defaultPadding * 0.75),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tran.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Text(
                      tran.type.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Text(
                "USD ${tran.amount}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: primaryColor),
              )
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          const Divider(),
        ],
      ),
    );
  }
}

class StatusOfItems extends StatelessWidget {
  const StatusOfItems({
    super.key,
    required this.transactionType,
  });

  final TransactionType transactionType;

  Color _getBackgroundColor() {
    switch (transactionType) {
      case TransactionType.DEPOSIT:
        return Colors.green;
      case TransactionType.RETURN_DEPOSIT:
        return Colors.red;
      case TransactionType.TOP_UP:
        return Colors.blue;
      case TransactionType.PAYMENT:
        return Colors.orange;
      }
  }

  IconData _getIconData() {
    switch (transactionType) {
      case TransactionType.DEPOSIT:
        return Icons.check;
      case TransactionType.RETURN_DEPOSIT:
        return Icons.close;
      case TransactionType.TOP_UP:
        return Icons.arrow_upward;
      case TransactionType.PAYMENT:
        return Icons.payment;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: CircleAvatar(
        backgroundColor: _getBackgroundColor(),
        radius: 12,
        child: Icon(
          _getIconData(),
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
