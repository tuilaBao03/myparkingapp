// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingapp/screens/invoice/invoice_details_screen.dart';

import '../../../constants.dart';
import '../../../data/response/invoice_response.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({
    super.key, required this.invoice,
  });
  final InvoiceResponse invoice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>InvociceDetailsScreen(invoice: invoice,))
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusOfItems(numOfItem: invoice.status),
              const SizedBox(width: defaultPadding * 0.75),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Text(
                      invoice.vehicle.vehicleType.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Text(
                "USD ${invoice.totalAmount}",
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
    required this.numOfItem,
  });

  final InvoiceStatus numOfItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      
      ),
      child: CircleAvatar(
        backgroundColor: numOfItem == InvoiceStatus.PAID ? Colors.green : numOfItem == InvoiceStatus.CANCELLED ? Colors.red : Colors.yellow,
        child: Icon(
          numOfItem == InvoiceStatus.PAID ? Icons.check : numOfItem == InvoiceStatus.CANCELLED ? Icons.close : Icons.warning,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
