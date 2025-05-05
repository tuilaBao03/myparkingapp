import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_slot_request.dart';

abstract class ParkingSlotEvent{}


class GetParkingSlotByLotIdEvent extends ParkingSlotEvent{
  String lotId;
  GetParkingSlotByLotIdEvent(this.lotId);
}
class UpdateParkingSlotEvent extends ParkingSlotEvent{
  String parkingSlotId;
  UpdateParkingSlotResponse request;
  UpdateParkingSlotEvent(this.parkingSlotId, this.request);
}