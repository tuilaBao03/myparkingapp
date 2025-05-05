import 'package:myparkingapp/data/response/parking_slots_response.dart';

abstract class LotDetailState{

}
class LotDetailInitial extends LotDetailState{

}
class LoadingLotDetailState extends LotDetailState{

}
class LoadedLotDetailState extends LotDetailState{
  List<DataOnFloor> dataOnFloor;
  LoadedLotDetailState(this.dataOnFloor);
}
class LotDetailErrorScreen extends LotDetailState{
  final String mess;
  LotDetailErrorScreen(this.mess);
}