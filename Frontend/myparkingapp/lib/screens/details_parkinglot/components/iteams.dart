import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import '../../../constants.dart';
import '../../../data/response/parking_slots_response.dart';
import '../../booking/booking_screen.dart';

class Items extends StatelessWidget {
  final ParkingLotResponse lot;
  final List<ParkingSlotResponse> slots;
  final UserResponse user;
  const Items({super.key, required this.slots, required this.lot, required this.user});

  @override
  Widget build(BuildContext context) {
    print(slots.length);
    // Split demoData into 2 parts for 2 columns
    List<ParkingSlotResponse> firstColumnData = slots.where((slot)=>slot.vehicleType.name == 'CAR').toList();
    List<ParkingSlotResponse> secondColumnData = slots.where((slot)=>slot.vehicleType.name == 'MOTORCYCLE' || slot.vehicleType.name =='BICYCLE').toList();
    int middle = (secondColumnData.length / 2).ceil();

    List<ParkingSlotResponse> firstHalf = secondColumnData.sublist(0, middle);
    List<ParkingSlotResponse> secondHalf = secondColumnData.sublist(middle);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Column
            Expanded(
              flex: 5,
              child: Column(
                children: List.generate(
                  firstColumnData.length,
                      (index) => Container(
                        color: Colors.transparent,
                        height: Get.width / 4, // Tăng chiều cao để chứa đầy đủ nội dung
                        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(firstColumnData[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                            firstColumnData[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                          ),
                          onPressed:(){
                            firstColumnData[index].slotStatus == SlotStatus.AVAILABLE
                                ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(lot: lot, slot: firstColumnData[index], user: user),
                              ),
                            ):AppDialog.showErrorEvent(context, "This Slot was not available");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  RegExp(r'\)(\d+)')
                                      .firstMatch(firstColumnData[index].slotName)
                                      ?.group(1) ?? '',
                                  style: TextStyle(fontSize: Get.width / 20),
                                ),
                              ),
                              Expanded(flex: 1, child: Image.asset("assets/icons/icon_car.png",fit: BoxFit.cover,),)
                            ],
                          ),)
                      ),
                ),
              ),
            ),
            SizedBox(width: Get.width / 10), // Spacing between columns
            // Second Column
            Expanded(
              flex: 4,
              child: Column(
                children: List.generate(
                  firstHalf.length,
                      (index) => Container(
                          padding: EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                          height: Get.width / 6, width: Get.width/4,// Tăng chiều cao để chứa đầy đủ nội dung
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(firstHalf[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                              firstHalf[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                            ),
                            onPressed:(){
                              firstHalf[index].slotStatus == SlotStatus.AVAILABLE
                                  ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(lot: lot, slot: firstHalf[index], user: user),
                                ),
                              ):AppDialog.showErrorEvent(context, "This Slot was not available");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(flex: 1, child: Text(firstHalf[index].slotName,style: TextStyle(fontSize: Get.width/40),)),
                                Expanded(flex: 2, child: Image.asset("assets/icons/icon_moto.png",fit: BoxFit.cover,),)
                              ],
                            ),)
                      ),
                  ),
                ),
              ),
            Expanded(
              flex: 4,
              child: Column(
                children: List.generate(
                  secondHalf.length,
                      (index) => Container(
                      padding: EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                      height: Get.width / 6, width: Get.width/4,// Tăng chiều cao để chứa đầy đủ nội dung
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(secondHalf[index].slotStatus == SlotStatus.AVAILABLE ? Colors.green[300] :
                          secondHalf[index].slotStatus == SlotStatus.RESERVED ? Colors.amber : Colors.red),
                        ),
                        onPressed:(){
                          secondHalf[index].slotStatus == SlotStatus.AVAILABLE
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(lot: lot, slot: secondHalf[index], user: user),
                            ),
                          ):AppDialog.showErrorEvent(context, "This Slot was not available");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 1, child: Text(secondHalf[index].slotName,style: TextStyle(fontSize: Get.width/40),)),
                            Expanded(flex: 2, child: Image.asset("assets/icons/icon_moto.png",fit: BoxFit.cover,),)
                          ],
                        ),)
                  ),
                ),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> demoData = List.generate(
  4, // Now with 4 items to make 2 per column
      (index) => {
    "image": "assets/images/featured _items_${index + 1}.png",
    "title": "Cookie Sandwich ${index + 1}",
    "description": "Shortbread, chocolate turtle cookies, and red velvet.",
    "price": 7.4,
    "foodType": "Chinese",
    "priceRange": "\$" * 2,
  },
);


