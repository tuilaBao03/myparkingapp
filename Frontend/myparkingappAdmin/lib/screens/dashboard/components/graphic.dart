// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_bloc.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_event.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_state.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/dashboard/components/assets_details.dart';
import 'package:myparkingappadmin/screens/dashboard/components/card_info.dart';
import 'package:myparkingappadmin/screens/dashboard/components/invoice_chart.dart';
import 'package:myparkingappadmin/screens/dashboard/components/transaction_chart.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';

class Graphic extends StatefulWidget {
  final UserResponse user;
  const Graphic({super.key, required this.user});

  @override
  State<Graphic> createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Ẩn nút back
          title: Text(AppLocalizations.of(context).translate("Diagram")),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // Không có màu nền
                  side: BorderSide(
                      color:
                          Colors.black), // Không có viền// Màu chữ (tùy chỉnh)
                ),
                onPressed: (
                  
                ) {
                  context
                      .read<DashboardBloc>()
                      .add(DashboardInitialEvent(widget.user));
                },
                child: Text(
                  AppLocalizations.of(context).translate("MANAGEMENT"),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: BlocConsumer<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardLoadedAdminState) {
              List<InvoiceResponse> invoices = state.invoices;
              double totalAmount = 0;
              for (var invoice in invoices) {
                totalAmount += invoice.totalAmount;
              }
              double commission = totalAmount * 0.2;

              List<TransactionResponse> transactions = state.transaction;
              return Container(
                height: Get.height * 1.4,
                width: Get.width,
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("TRANSACTION MANAGEMENT"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: Get.height * 0.4,
                                child: TransactionBarChartWidget(
                                  data: transactions,
                                  type: TransactionType.PAYMENT,
                                )),
                            SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)
                                  .translate("INVOICE MANAGEMENT"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: Get.height * 0.4,
                                child: InvoiceBarChartWidget(
                                  data: invoices,
                                  type: InvoiceStatus.PAID,
                                )),
                          ],
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)
                                .translate("ASSET DETAILS"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          AssetsDetails(totalAmount, commission,
                              totalAmount - commission),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DashboardLoadedOwnerState) {
              List<InvoiceResponse> invoices = state.invoices;
              double totalAmount = 0;
              for (var invoice in invoices) {
                totalAmount += invoice.totalAmount;
              }
              double commission = totalAmount * 0.2;

              List<ParkingLotResponse> lots = state.parkingLot;
              return Container(
                padding: EdgeInsets.all(10),
                height: Get.height * 1.4,
                width: Get.width,
                color: Theme.of(context).colorScheme.secondary,
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)
                                    .translate("PARKING LOT"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: lots
                                      .map((e) => InforOfParkingLot(info: e))
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            Text(
                                AppLocalizations.of(context)
                                    .translate("INVOICE MANAGEMENT"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  color: Theme.of(context).colorScheme.primary,
                                  height: Get.height * 0.4,
                                  child: InvoiceBarChartWidget(
                                    data: invoices,
                                    type: InvoiceStatus.PAID,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)
                                    .translate("ASSET DETAILS"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              AssetsDetails(totalAmount, commission,
                                  totalAmount - commission),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
              );
            }
            return Center(
              child: Image.asset(
                "assets/images/admin-Photoroom.jpg",
                width: Get.width / 4,
                fit: BoxFit.fill,
              ),
            );
          },
          listener: (context, state) {
            if (state is DashboardErrorState) {
              AppDialog.showErrorEvent(context, state.mess);
            }
          },
        ));
  }
}
