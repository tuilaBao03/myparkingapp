import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvociceDetailsScreen extends StatelessWidget {
  final InvoiceResponse invoice;
  
  const InvociceDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate("Your Invoice")),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.map_outlined)),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_invoice.png", // Đường dẫn đến GIF trong thư mục assets
              fit: BoxFit.cover,
            ),
          ),
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/30),
                ObjectRow(title: "parkingLotName",content: invoice.parkingLotName),
                SizedBox(height: Get.width/30),
                ObjectRow(title: "parkingSlotName",content: invoice.parkingSlotName),
                SizedBox(height: Get.width/30),
                ObjectRow(title: "Invoice Type",content: invoice.isMonthlyTicket ? "Month":"Date"),
                SizedBox(height: Get.width/30),

                Text(
                  AppLocalizations.of(context).translate("Description"),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  invoice.description,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Get.width/30),
                PrimaryButton(
                      text: AppLocalizations.of(context).translate("Discount"),
                      press: () {
                        AppDialog.showDetailDiscount(context, invoice.discount);
                      },
<<<<<<< HEAD
                    ):
                SizedBox(height: 10),

                SizedBox(height: 10),
                PrimaryButton(
                  text: "${AppLocalizations.of(context).translate("Vehicle")} : ${invoice.vehicle.licensePlate}",
                  press: () {
                    AppDialog.showDetailVehicle(context, invoice.vehicle);
                  },
=======
                    ),
                SizedBox(height: Get.width/30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(  // Dùng Column để chứa danh sách nút bấm
                        children: List.generate(invoice.transaction.length, (index) {
                          return PrimaryButton(
                            text: "${AppLocalizations.of(context).translate("Transaction")} ${index + 1} ${invoice.transaction[index].type.name}",
                            press: () {
                              AppDialog.showDetailTransaction(context, invoice.transaction[index]);
                            },
                          );
                        }),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          PrimaryButton(
                            text: AppLocalizations.of(context).translate("Vehicle"),
                            press: () {
                              AppDialog.showDetailVehicle(context, invoice.vehicle);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
>>>>>>> main
                ),
                
                SizedBox(height: 10),
                Center(child: Text(AppLocalizations.of(context).translate("QR IN - OUR "),style: TextStyle(color: Colors.white),),),
                Center(
                  child: QrImageView(
                    backgroundColor: Colors.white,
                    data: invoice.objectDecrypt,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                Spacer(),
<<<<<<< HEAD
                TotalPrice(price: invoice.totalAmount, current: 'USD',),
=======
                TotalPrice(price: invoice.totalAmount),
>>>>>>> main
                SizedBox(height: Get.width/10),
              ],
            ),
          ),
        
      
        ],
        ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;

  const PrimaryButton({super.key, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding = const EdgeInsets.symmetric(vertical: 16);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
              style: TextButton.styleFrom(
                padding: verticalPadding,
                backgroundColor: const Color(0xFF22A45D),
              ),
              onPressed: press,
              child: buildText(context),
            ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate(text).toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}