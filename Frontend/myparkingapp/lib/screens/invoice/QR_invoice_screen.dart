import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/screens/booking/components/rounded_checkedbox_list_tile.dart';
import 'package:myparkingapp/screens/invoice/components/object_row.dart';
import 'package:myparkingapp/screens/invoice/components/total_price.dart';
import 'package:myparkingapp/screens/invoice/order_invoice_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constants.dart';

class QRInvoiceScreen extends StatefulWidget {
  final Invoice_QR request;
  final UserResponse user;
  const QRInvoiceScreen({super.key, required this.request, required this.user});

  @override
  State<QRInvoiceScreen> createState() => _QRInvoiceScreenState();
}

class _QRInvoiceScreenState extends State<QRInvoiceScreen> {
  InvoiceResponse? invoice;
  bool isShowWallet = false;
  List<WalletResponse> wallets = [];
  WalletResponse? wallet;

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(GetInvoiceByIDEvent(widget.request.InvoiceID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.greenAccent,
              size: 18,
            ),
          );
        } else if (state is GetInvoiceByIDState) {
          invoice = state.invoice;
          wallets = state.wallets!;
          double total = invoice!.isMonthlyTicket ? invoice!.totalAmount : (invoice!.totalAmount / 3) * tinhSoGio(invoice!.createdAt, DateTime.now()) - invoice!.totalAmount;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                  onPressed:
                      () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => OrderInvoiceScreen(user: widget.user,)),
                        ),
                      },
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate(invoice!.parkingLotName),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(

                children: [
              Positioned.fill(
              child: Image.asset(
                "assets/images/qr_background.png",
                // Đường dẫn đến GIF trong thư mục assets
                fit: BoxFit.cover,
              ),
                        ),Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding),

                        ObjectRow(title: "parkingSlotName",content: invoice!.parkingSlotName),
                        SizedBox(height: Get.width/30),
                        ObjectRow(title: "startD",content: DateFormat('dd/MM/yyyy HH:mm:ss').format(invoice!.createdAt) ),
                        SizedBox(height: Get.width/30),
                        ObjectRow(title: "endD",content: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())),
                        SizedBox(height: Get.width/30),
                        const SizedBox(height: defaultPadding),


                        Center(child: Text(AppLocalizations.of(context).translate("QR IN - OUR"),style: TextStyle(color: Colors.white),),),
                        const SizedBox(height: defaultPadding),
                        Center(
                          child: QrImageView(
                            backgroundColor: Colors.white,
                            data: widget.request.QR,
                            version: QrVersions.auto,
                            size: Get.width/1.1,
                          ),
                        ),
                        const SizedBox(height: defaultPadding*2),
                        TotalPrice(price: total, current: wallet !=null ? wallet!.currency : "USD",),
                        const SizedBox(height: defaultPadding),
                        if(invoice!.status == InvoiceStatus.PENDING && invoice!.isMonthlyTicket == false)
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isShowWallet = !isShowWallet;
                                  });
                                },
                                child: Text(

                                  wallets.isEmpty
                                      ? AppLocalizations.of(context).translate("You haven't added a wallet")
                                      : wallet != null
                                      ? "${AppLocalizations.of(context).translate("Choice a wallet") }: ${wallet!.name}"
                                      : "${AppLocalizations.of(context).translate("Choice a wallet")} :",
                                ),

                              ),
                              const SizedBox(height: defaultPadding),
                              Visibility(
                                visible: isShowWallet,
                                child: Column(
                                  children: wallets
                                      .map((w) => RoundedCheckboxListTile(
                                    isActive: (wallet == w),
                                    text: "${AppLocalizations.of(context).translate(w.name)} ${w.currency}",
                                    press: () {
                                      setState(() {
                                        wallet = w;
                                      });
                                    },
                                  ))
                                      .toList(),
                                ),
                              ),
                              ElevatedButton(onPressed:(){

                                if( invoice!.discount != null){
                                  if(invoice!.discount!.discountType == DiscountType.FIXED){
                                    total = total - invoice!.discount!.discountValue;
                                  }
                                  else{
                                    total = total * invoice!.discount!.discountValue;
                                  }
                                }
                                if(wallet !=null){
                                  PaymentDailyRequest request = PaymentDailyRequest(invoiceID: invoice!.invoiceID, parkingSlotID: invoice!.parkingSlotID, walletID: wallet!.walletId, total: total);
                                  context.read<InvoiceBloc>().add(CreatedPaymentInvoiceEvent(request));
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(AppLocalizations.of(context).translate("Lack info wallet")),
                                        duration: Duration(seconds: 3), // thời gian hiển thị
                                        backgroundColor: Colors.green,
                                      ));
                                }

                              }, child: Text(AppLocalizations.of(context).translate("payment").toUpperCase())),
                            ],
                          )
                        // List of cart items
                      ],
                    ),
                  ),
                ]),
            )

          );
        }
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.greenAccent,
            size: 25,
          ),
        );
      },
      listener: (context, state) {
        if (state is InvoiceErrorState) {
          AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate( state.mess),onPress:()=>{
            context.read<InvoiceBloc>().add(GetInvoiceByIDEvent(widget.request.InvoiceID))
          });
        }
        if(state is InvoiceSuccessState){
          AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess ),onPress:()=>{
          context.read<InvoiceBloc>().add(GetInvoiceByIDEvent(widget.request.InvoiceID))
          });
        }
      },
    );
  }
}

int tinhSoGio(DateTime batDau, DateTime ketThuc) {
  Duration khoangThoiGian = ketThuc.difference(batDau);
  return khoangThoiGian.inHours;
}


