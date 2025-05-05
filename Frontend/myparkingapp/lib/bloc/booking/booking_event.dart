import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/demo_data.dart';

abstract class BookingEvent{}

// class BookingInitialEvent extends BookingEvent{
//   final ParkingLotResponse lot;
//   BookingInitialEvent( this.lot);
// }

class BookingInitialInvoiceEvent extends BookingEvent{
  final UserResponse user;
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  BookingInitialInvoiceEvent( this.lot,
      this.slot, this.user);
}
class GetMonthOderEvent extends BookingEvent{
  final UserResponse user;
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;
  DiscountResponse? discount;
  final MonthInfo monthList;
  final WalletResponse wallet;
  final VehicleResponse vehicle;
  GetMonthOderEvent( this.lot,this.slot,this.discount,
      this.monthList, this.wallet, this.vehicle,this.user);
}

class GetDateOderEvent extends BookingEvent{
  final UserResponse user;
  final ParkingSlotResponse slot;
  DiscountResponse? discount;
  final DateTime start;
  final WalletResponse wallet;
   final VehicleResponse vehicle;
  GetDateOderEvent( this.user,this.slot,this.discount,
      this.start, this.wallet, this.vehicle);
}