import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';

abstract class  ParkingSlotState{}

class  ParkingSlotInitial extends ParkingSlotState{

}

class  ParkingSlotLoadingState extends ParkingSlotState{

}

class  ParkingSlotLoadedState extends ParkingSlotState{
  List<SLotByFloor>  listFloor;
  ParkingSlotLoadedState(this.listFloor);

}

class  ParkingSlotErrorState extends ParkingSlotState{
  String mess;
  ParkingSlotErrorState(this.mess);
}

class  ParkingSlotSuccessState extends ParkingSlotState{
  String mess;
  ParkingSlotSuccessState(this.mess);


}