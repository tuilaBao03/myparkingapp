// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/booking/booking_bloc.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/demo_data.dart';
import 'package:myparkingapp/screens/invoice/invoice_create.dart';
import 'package:myparkingapp/screens/search/search_screen.dart';
import '../../bloc/booking/booking_event.dart';
import '../../bloc/booking/booking_state.dart';
import '../../constants.dart';
import '../../data/response/discount_response.dart';
import 'components/info.dart';
import 'components/required_section_title.dart';
import 'components/rounded_checkedbox_list_tile.dart';

class BookingScreen extends StatefulWidget {
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  final UserResponse user;

  const BookingScreen({super.key, required this.lot, required this.slot, required this.user});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool isMonthly = false;
  bool isDate = false;
  bool isShowDiscount = false;
  bool isShowWallet = false;
  bool isVehicle = false;

  DiscountResponse? discount;
  List<DiscountResponse> discounts = [];
  DateTime start = DateTime.now();
  List<MonthInfo> monthSelect = [];
  List<WalletResponse> wallets = [];
  WalletResponse? wallet;
  VehicleResponse? vehicle;
  List<VehicleResponse> vehicles = [];
  MonthInfo selectMonth = MonthInfo("March", DateTime(1, 3, 2025), DateTime(31, 3, 2025));

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(
        BookingInitialInvoiceEvent(widget.lot, widget.slot,widget.user));
  }

  List<List<T>> splitList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchScreen(),))
              },
            ),
          ),
        ),
        body: BlocConsumer<BookingBloc, BookingState>(builder: (context, state) {
          if (state is BookingLoadingState) {
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
          } else if (state is BookingLoadedState) {
            monthSelect = state.monthLists;
            discounts = state.discounts;
            wallets = state.wallets;
            vehicles = state.vehicles;
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Info(lot: widget.lot, slot: widget.slot),
                    const SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RequiredSectionTitle(title: "Choice"),
                          const SizedBox(height: defaultPadding),
                          ...List.generate(
                            monthOrDate.length,
                            (index) => RoundedCheckboxListTile(
                              text: AppLocalizations.of(context).translate(monthOrDate[index]),
                              isActive: (monthOrDate[index] == 'ByMonth' && isMonthly) || (monthOrDate[index] == 'ByDate' && isDate),
                              press: () {
                                setState(() {
                                  isMonthly = monthOrDate[index] == 'ByMonth';
                                  isDate = monthOrDate[index] == 'ByDate';
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding),

                          if (isMonthly) ...[
                            RequiredSectionTitle(title: " ${AppLocalizations.of(context).translate("Choice Month")} : ${ selectMonth.monthName}"),
                            const SizedBox(height: defaultPadding),

                            Row(
                              children: splitList(monthSelect, (monthSelect.length / 3).ceil()).map((chunk) {
                                return Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: chunk
                                        .map((month) => RoundedCheckboxListTile(
                                              isActive: (selectMonth.monthName == month.monthName),
                                              text: AppLocalizations.of(context).translate(month.monthName),
                                              press: () {
                                                setState(() {
                                                  selectMonth = month;
                                                });
                                              },
                                            ))
                                        .toList(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],

                          if (isDate) ...[
                            RequiredSectionTitle(title: "${AppLocalizations.of(context).translate("Start Time")} :"),
                            SizedBox(height: 8),
                            Center(
                              child: Text(
                              DateFormat('dd/MM/yyyy HH:mm:ss').format(start).toString(),
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a vehicle :"),
                          // Nút ẩn/hiện Discount
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isVehicle = !isVehicle;
                              });
                            },
                            child: Text(
                              vehicles.isEmpty
                                  ? AppLocalizations.of(context).translate("You haven't added vehicle")
                                  : vehicle != null
                                  ? "${AppLocalizations.of(context).translate("Choice a vehicle")} : ${vehicle!.licensePlate}"
                                  : AppLocalizations.of(context).translate("Choice a vehicle"),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Visibility(
                            visible: isVehicle,
                            child: Column(
                              children: [
                                
                                ...vehicles.map((v) => RoundedCheckboxListTile(
                                      isActive: (vehicle!.licensePlate == v.licensePlate),
                                      text: "${v.licensePlate} ${  AppLocalizations.of(context).translate(v.vehicleType.name)}",
                                      press: () {
                                        setState(() {
                                          vehicle = v;
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a favorite discount :"),
                          // Nút ẩn/hiện Discount
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isShowDiscount = !isShowDiscount;
                              });
                            },
                            child: Text(
                              discounts.isEmpty
                                  ? AppLocalizations.of(context).translate("There wasn't any suitable discount")
                                  : discount != null
                                  ? "${AppLocalizations.of(context).translate(
                                  "Choice a favorite discount")} : ${discount!.discountCode}"
                                  : AppLocalizations.of(context).translate("Choice a favorite discount :"),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Visibility(
                            visible: isShowDiscount,
                            child: Column(
                              children: [
                                ...discounts.map((d) => RoundedCheckboxListTile(
                                      isActive: (discount == d),
                                      text: "${d.discountCode} ${  AppLocalizations.of(context).translate(d.discountValue.toString())} ${d.discountType == DiscountType.FIXED ? "USD" : "%"}",
                                      press: () {
                                        setState(() {
                                          discount = d;
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          RequiredSectionTitle(title: "Choice a wallet :"),

                          // Nút ẩn/hiện Wallet
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
                                  ? "${AppLocalizations.of(context).translate("Choice a wallet")} : ${wallet!.name}"
                                  : AppLocalizations.of(context).translate("Choice a wallet :"),
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
                                          // context.read<BookingBloc>().add(BookingInitialInvoiceEvent(discount, start, widget.lot, widget.slot, selectMonth, w, vehicle,widget.user));
                                          setState(() {
                                            wallet = w;
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          const SizedBox(height: defaultPadding),
                          Center(
                          child: SizedBox(
                            width: Get.width/2,
                            height: Get.width/8,
                            child: ElevatedButton(
                              
                              onPressed: () {
                                if(wallet != null && vehicle != null){
                                  isMonthly ? context.read<BookingBloc>().add(GetMonthOderEvent(widget.lot,widget.slot, discount,selectMonth, wallet!, vehicle!,widget.user)):
                                  context.read<BookingBloc>().add(GetDateOderEvent(widget.user,widget.slot, discount,start, wallet!, vehicle!));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(AppLocalizations.of(context).translate("Lack info (wallet or vehicle")),
                                        duration: Duration(seconds: 3), // thời gian hiển thị
                                        backgroundColor: Colors.green,
                                      ));
                                }

                              },
                              child:  Text(AppLocalizations.of(context).translate("Booking Now").toUpperCase()),
                            ),
                          ),
                        ),const SizedBox(height: defaultPadding),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        },listener:(context,state){
            if(state is GotoInvoiceCreateDetailState){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>InvoiceCreateScreen(state.invoiceD, state.invoiceM, widget.slot,widget.lot, wallet!, widget.user, vehicle!, discount!),
                  ),
                );
            }
            else if (state is BookingErrorState){
              return AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
            }
          }
        )
        );
  }

  List<String> monthOrDate = ["ByMonth", "ByDate"];
}
