import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

abstract class HomeState{

}

class HomeInitialState extends HomeState{}

class HomeLoadedState extends HomeState{
  final UserResponse user;
  final List<ParkingLotResponse> homeLots;
  final List<ParkingLotResponse> nearlyLots;
  HomeLoadedState(this.homeLots,this.nearlyLots, this.user);
}
class HomeLoadingState extends HomeState{

}
class HomeErrorState extends HomeState{
  final String mess;
  HomeErrorState(this.mess);
}

class GotoSearchScreen extends HomeState{
  final LotOnPage lotOnPage;
  GotoSearchScreen(this.lotOnPage);
}