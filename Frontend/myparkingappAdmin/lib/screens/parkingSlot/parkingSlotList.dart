// ignore_for_file: file_names, library_private_types_in_public_api, prefer_final_fields, avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:myparkingappadmin/bloc/parking_slot/slot_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_event.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_state.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';
import 'package:myparkingappadmin/screens/invoice/Invoice_list.dart';
import '../../app/localization/app_localizations.dart';
import '../../constants.dart';
import 'parkingSlotDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkingSlotList extends StatefulWidget {
  final ParkingLotResponse parkingLot;

  const ParkingSlotList({
    super.key,
    required this.parkingLot,
  });

  @override
  _ParkingSlotListState createState() => _ParkingSlotListState();
}

class _ParkingSlotListState extends State<ParkingSlotList> {
   List<SLotByFloor> slotsByFloor = [];
   bool isDetail = false;
  ParkingSlotResponse object = ParkingSlotResponse(
    slotName: "",
    vehicleType: "",
    slotId: '',
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 0,
    pricePerMonth: 0,
    parkingLotId: '',);

  @override
  void initState() {
    super.initState();
    context.read<ParkingSlotBloc>().add(GetParkingSlotByLotIdEvent(widget.parkingLot.parkingLotId));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 🔒 Ẩn nút quay về
          title:
              Text("${widget.parkingLot.parkingLotName}/${AppLocalizations.of(context).translate("Parking Lot List")}"),
        ),
        body: BlocConsumer<ParkingSlotBloc,ParkingSlotState>(builder: (context, state) {
          if (state is ParkingSlotLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ParkingSlotLoadedState) {
            slotsByFloor = state.listFloor;
            List<String> floorNames = slotsByFloor[0].floorNames;

            return Container(
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
                    SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: DefaultTabController(
                            length: floorNames.length,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  tabs: floorNames.map((floorName) => Tab(text: floorName)).toList(),
                                  labelColor: Theme.of(context).colorScheme.primary,
                                  unselectedLabelColor: Colors.grey,
                                ),
                                SizedBox(
                                  height: 400, // hoặc dùng `MediaQuery.of(context).size.height * 0.5`
                                  child: TabBarView(
                                    children: slotsByFloor.map((floor) {
                                      return SlotGraphic(
                                        slots: floor.parkingSlots,
                                        onInvoiceTap: (slot){
                                          setState(() {
                                            object = slot;
                                            _showInvoiceList(context,slot);
                                          });
                                        },
                                        onDetailTap: (slot) {
                                          setState(() {
                                            object = slot;
                                            _showSlotDetail(context,slot);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),  
                        const SizedBox(width: 10),
                    
                        
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }, listener: (context, state) {
          if (state is ParkingSlotSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess);
          } else if (state is ParkingSlotErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        }));
  }
  void _showInvoiceList(BuildContext context, ParkingSlotResponse slot){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: Get.height/1.2,
            width: Get.width/1.2,
            child: InvoiceList(parkingSlot: slot,),
          ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel, color: Colors.red,),
          ),
        ],
      );
    },
  );
}
void _showSlotDetail(BuildContext context, ParkingSlotResponse slot){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: Get.height/1.1,
            width: Get.width/2,
            child:ParkingSlotDetail(object: object, onEdit: () { 
                            setState(() {
                              isDetail = false; // Chuyển về chế độ xem
                            });
            })
            
            
             ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel, color: Colors.red,),
          ),
        ],
      );
    },
  );
}
  }




// Hàm tạo hàng dữ liệu
class SlotGraphic extends StatelessWidget {
  final List<ParkingSlotResponse> slots;
  final Function(ParkingSlotResponse) onInvoiceTap;
  final Function(ParkingSlotResponse) onDetailTap;

  const SlotGraphic({
    super.key,
    required this.slots,
    required this.onInvoiceTap,
    required this.onDetailTap,
  });

  Widget _buildSlotBox(ParkingSlotResponse slot) {
    return Container(
      height: Get.width/30,
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(slot.slotName, style: const TextStyle(color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.receipt_long, color: Colors.white),
                onPressed: () => onInvoiceTap(slot),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.white),
                onPressed: () => onDetailTap(slot),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ParkingSlotResponse> cars = slots.where((slot) => slot.vehicleType.toLowerCase().contains("car")).toList(); 
    final List<ParkingSlotResponse> motorbikes = slots.where((slot) => slot.vehicleType.toLowerCase().contains("moto")).toList();

    int total = motorbikes.length;
    int partSize = (total / 3).ceil();

    final list1 = motorbikes.sublist(0, partSize);
    final list2 = motorbikes.sublist(partSize, (partSize * 2).clamp(0, total));
    final list3 = motorbikes.sublist((partSize * 2).clamp(0, total), total);

    return Row(
      children: [
        for (var list in [cars, list1, list2, list3])
          Expanded(
            child: Column(
              children: list.map(_buildSlotBox).toList(),
            ),
          )
      ],
    );
  }
}

