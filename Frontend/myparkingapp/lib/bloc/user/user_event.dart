import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/add_vehicle_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

abstract class UserEvent {}

class UpdateUserInfo extends UserEvent{
  UserResponse user;
  UpdateUserRequest newUser;
  UpdateUserInfo(this.user,this.newUser);
}

class LoadUserDataEvent extends UserEvent{
  LoadUserDataEvent();
}

class ChangePassword extends UserEvent{
  String oldPass;
  String newPass;
  ChangePassword(this.newPass,this.oldPass);
}

class AddNewVehicle extends UserEvent{
  CreateVehicleRequest vehicle;
  AddNewVehicle(this.vehicle);

}

class DeleteVehicle extends UserEvent{
  String vehicleID;
  DeleteVehicle(this.vehicleID);
}