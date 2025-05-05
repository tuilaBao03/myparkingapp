// ignore_for_file: library_private_types_in_public_api, avoid_print, non_constant_identifier_names, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_event.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_state.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/discount/discount_list.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/parkingLot/createParkingLot.dart';
import 'package:myparkingappadmin/screens/parkingSlot/parkingSlotList.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';

import 'parkingLotDetail.dart';

class ParkingLotList extends StatefulWidget {
  final UserResponse user;

  const ParkingLotList({super.key, required this.user});

  @override
  _ParkingLotListState createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  bool isDetail = false;
  ParkingLotResponse? lot;

  Set<String> objectColumnNameOfParkingLot = {
    "ParkingLotName",
    "Status",
    "Detail",
  };
  List<ParkingLotResponse> parkingLots = [];

  @override
  void initState() {
    context.read<ParkingLotBloc>().add(
          GetParkingLotByOwnerEvent(
            widget.user.userId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
          title: Text(
              "${widget.user.firstName} ${widget.user.lastName}/ ${AppLocalizations.of(context).translate("Parking Lot List")}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<ParkingLotBloc>().add(
                      GetParkingLotByOwnerEvent(
                        widget.user.userId,
                      ),
                    );
              },
            ),

            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddParkingSlotDialog(context,widget.user);
              },
            ),
          ],
        ),
        body: BlocConsumer<ParkingLotBloc, ParkingLotState>(
            builder: (context, state) {
          if (state is ParkingLotLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ParkingLotLoadedState) {
            parkingLots = state.parkingLotList;
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate("ParkingLot"),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(height: defaultPadding),
                          parkingLots.isEmpty
                              ? Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                        "There is no matching information"),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              : _buildDataTable(context),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                isDetail
                    ? Expanded(
                        flex: 1,
                        child: ParkingSpotDetail(parkingLot: lot!, onEdit: () { setState(() {
                          isDetail = false;
                        }); },),
                      )
                    : SizedBox(
                        width: 0,
                      ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }, listener: (context, state) {
          if (state is ParkingLotSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess);
          } else if (state is ParkingLotErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        }));
  }

  Widget _buildDataTable(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 16.0,
        columns: objectColumnNameOfParkingLot
            .map((name) => DataColumn(
                  label: Text(AppLocalizations.of(context).translate(name),
                      overflow: TextOverflow.ellipsis, maxLines: 1),
                ))
            .toList(),
        rows: parkingLots.map((lot) {
          return _buildDataRow(lot, context);
        }).toList(),
      ),
    );
  }

  DataRow _buildDataRow(ParkingLotResponse parkingLot, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(parkingLot.parkingLotName)),
        DataCell(Text(parkingLot.status.toString())),
        DataCell(Row(
          children: [
            Expanded(
              child: IconButton(
                  icon: const Icon(Icons.details, color: Colors.green),
                  onPressed: () => setState(() {
                        isDetail = true;
                        lot = parkingLot;
                      })),
            ),
            SizedBox(width: 10),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.discount, color: Colors.orangeAccent),
                onPressed: () => _showDiscountDialog(context, parkingLot),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.location_on, color: Colors.blue),
                onPressed: () => _showSlotDialog(context, parkingLot),
              ),
            ),
            SizedBox(width: 10),
          ],
        )),
      ],
    );
  }

  void _showDiscountDialog(BuildContext context, ParkingLotResponse lot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height/1.2,
            width: Get.width/1.2,
            child: DiscountList(
              parkingLot: lot,
            ),
          ),// Thay thế bằng widget chi tiết hợp đồng của bạn
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSlotDialog(BuildContext context, ParkingLotResponse lot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height/1.1,
            width: Get.width/1.2,
            child: ParkingSlotList(parkingLot: lot),
          ),
 // Thay thế bằng widget chi tiết hợp đồng của bạn
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
    void _showAddParkingSlotDialog(BuildContext context, UserResponse user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Get.height/1.2,
            width: Get.width/1.2,
            child: CreateParkingLotScreen(user: user,)
          ),
 // Thay thế bằng widget chi tiết hợp đồng của bạn
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
