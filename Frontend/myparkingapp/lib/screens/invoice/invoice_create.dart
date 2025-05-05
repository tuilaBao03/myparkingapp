// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';
import 'package:myparkingapp/screens/invoice/invoice_screen.dart';

class InvoiceCreateScreen extends StatelessWidget {
  InvoiceCreatedDailyRequest? invoiceD;
  InvoiceCreatedMonthlyRequest? invoiceM;
  final ParkingSlotResponse slot;
  final ParkingLotResponse lot;
  final WalletResponse wallet;
  final UserResponse user;
  final VehicleResponse vehicle;
  final DiscountResponse discount;

  InvoiceCreateScreen(
    this.invoiceD,
    this.invoiceM,
    this.slot,
    this.lot,
    this.wallet,
    this.user,
    this.vehicle,
    this.discount, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate("Your Orders")),
      ),
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/background_invoice.png",
                  // Đường dẫn đến GIF trong thư mục assets
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: Get.width / 30),
                    ObjectRow(
                      title: "parkingLotName",
                      content: lot.parkingLotName,
                    ),
                    // tran vien
                    SizedBox(height: Get.width / 30),
                    ObjectRow(title: "parkingSlotName", content: slot.slotName),
                    SizedBox(height: Get.width / 30),
                    ObjectRow(
                      title: "Booking by",
                      content: invoiceM != null ? "Month" : "Date",
                    ),
                    SizedBox(height: Get.width / 30),

                    Text(
                      AppLocalizations.of(context).translate("Description :"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      invoiceM != null
                          ? invoiceM!.description
                          : invoiceD!.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PrimaryButton(
                      text: "Discount",
                      press: () {
                        AppDialog.showDetailDiscount(context,discount);
                      },
                    ),
                    SizedBox(height: Get.width / 30),
<<<<<<< HEAD
                    ObjectRow(title: "Discount Code", content: discount.discountCode),
                    SizedBox(height: Get.width / 30),
                    ObjectRow(title: "Reduced", content: "${discount.discountValue} ${
                    discount.discountType == DiscountType.FIXED ? "USD" : "%"

                    }"),
                    SizedBox(height: Get.width / 30),
                    Text(
                      AppLocalizations.of(context).translate("Vehicle :"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
=======
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: PrimaryButton(
                            text: "${vehicle.licensePlate} ",
                            press: () {
                              AppDialog.showDetailVehicle(context, vehicle);
                            },
                          ),
                        ),
                      ],
>>>>>>> main
                    ),
                    Spacer(),
                    const TotalPrice(price: 20),
                    SizedBox(height: Get.width / 30),
                    PrimaryButton(
                      text: "Payment",
                      press: () {
                        context.read<InvoiceBloc>().add(
                          CreatedInvoiceEvent(invoiceD,invoiceM),
                        );
                      },
                    ),
                    SizedBox(height: Get.width / 30),
                  ],
                ),
              ),
            ],
          );
        },

        listener: (context, state) {
          if (state is InvoiceErrorState) {
            AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
          }

          if (state is InvoiceSuccessState) {
            AppDialog.showSuccessEvent(
              context,AppLocalizations.of(context).translate(
              state.mess),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvoiceScreen()),
                );
              },
            );
          }
        },
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
