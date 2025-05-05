import 'package:myparkingappadmin/data/dto/response/user_response.dart';

abstract class DashboardEvent {
  
}
class DashboardInitialEvent extends DashboardEvent {
  final UserResponse user;
  DashboardInitialEvent(this.user);
}