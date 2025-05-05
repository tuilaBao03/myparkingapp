// import 'package:myparkingapp/data/response/data_on_floor.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

abstract class LotDetailEvent {}
class LotDetailScreenInitialEvent extends LotDetailEvent{
  final ParkingLotResponse parkingLot;
  LotDetailScreenInitialEvent( this.parkingLot);
}
class LoadListLotsEvent extends LotDetailEvent{
  final String floorName;
  final ParkingLotResponse parkingLot;
  LoadListLotsEvent(this.floorName, this.parkingLot);
}

class GotoBookingScreenEvent extends LotDetailEvent{

}