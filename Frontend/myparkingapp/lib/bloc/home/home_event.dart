import 'package:myparkingapp/data/request/give_coordinates_request.dart';

abstract class HomeEvent{}

class HomeInitialEvent extends HomeEvent{
  Coordinates? coordinates;
  HomeInitialEvent(this.coordinates);
}
