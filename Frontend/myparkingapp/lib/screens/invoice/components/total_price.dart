import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: AppLocalizations.of(context).translate("Total"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Get.width/15,),
            children: [
              TextSpan(
                text: "(VAT)",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Text(
          "\$$price",
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Get.width/15),
        ),
      ],
    );
  }
}
