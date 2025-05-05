import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';
import '../../general/object_horizontal.dart';

class AssetsDetails extends StatelessWidget {
  final double totalAmount,income, commission;
  const AssetsDetails(
     this.totalAmount,
    this.income,
    this.commission, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height /1.5,
            padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate("AssetsDetails"),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            ObjectHorizontal(
              svgSrc: "assets/logos/xynsh-rect.svg",
              title: "Revenue",
              numOfObject: totalAmount,
            ),
            ObjectHorizontal(
              svgSrc: "assets/logos/zybank-rect.svg",
              title: "Commission",
              numOfObject: commission,
            ),
            ObjectHorizontal(
              svgSrc: "assets/logos/zxbk-rect.svg",
              title: "Income",
              numOfObject: income,
            ),
          ],
        ),
      ),
    );
  }
}
