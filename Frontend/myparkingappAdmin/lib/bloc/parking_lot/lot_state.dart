import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';

abstract class  ParkingLotState{}

class  ParkingLotInitial extends ParkingLotState{

}

class  ParkingLotLoadingState extends ParkingLotState{

}

class  ParkingLotLoadedState extends ParkingLotState{
  List<ParkingLotResponse> parkingLotList;
  ParkingLotLoadedState(this.parkingLotList);

}

class  ParkingLotErrorState extends ParkingLotState{
  String mess;
  ParkingLotErrorState(this.mess);
}

class  ParkingLotSuccessState extends ParkingLotState{
  String mess;
  ParkingLotSuccessState(this.mess);


}

class  ParkingLotUpdateImageState extends ParkingLotState{
  String mess;
  ParkingLotUpdateImageState(this.mess);


}