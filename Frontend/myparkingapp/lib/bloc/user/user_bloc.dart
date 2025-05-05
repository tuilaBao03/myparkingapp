import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/image_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
import 'package:myparkingapp/data/repository/vehicle_repository.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() :super(UserInitialState()) {
    on<UpdateUserInfo>(_updateUser);
    on<ChangePassword>(_changePassword);
    on<LoadUserDataEvent>(_loadStateInitial);
    on<AddNewVehicle>(_addNewVehicle);
    on<DeleteVehicle>(_deleteNewVehicle);
  }


  void _loadStateInitial(LoadUserDataEvent event,
      Emitter<UserState> emit) async {
    try {
      UserRepository userRepository = UserRepository();
      ApiResult userAPI = await userRepository.getMe();
      UserResponse user = userAPI.result;
      emit(UserLoadedState(user));
    }
    catch (e) {
      throw Exception("UserBloc_updateUser : $e");
    }
  }

  void _updateUser(UpdateUserInfo event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      UserRepository user = UserRepository();
      if(event.newUser.avatar.imageBytes != null)
      {
        ImageRepository imageRepository = ImageRepository();
        Cloudinary cloudinary = await imageRepository.getApiCloud();
        print("____________________${event.newUser.avatar.imagesID}");
        CloudinaryResponse uploadResponse = await imageRepository.uploadImage(
            cloudinary,
            event.newUser.avatar.imageBytes!,
            "myparkingapp/avatars",
            event.newUser.avatar.imagesID,
            event.newUser.avatar.imagesID);
        if (uploadResponse.isSuccessful) {
          ImagesResponse image = ImagesResponse(
              event.newUser.avatar.imagesID, uploadResponse.url, null);
          UpdateUserRequest request = UpdateUserRequest(
              firstName: event.newUser.firstName,
              lastName: event.newUser.lastName,
              email: event.newUser.email,
              phone: event.newUser.phone,
              homeAddress: event.newUser.homeAddress,
              companyAddress: event.newUser.companyAddress,
              avatar: image);
          ApiResult useApi = await user.updateUser(
              request, event.user.userID);
          if (useApi.code == 200) {
            emit(UserSuccessState(useApi.message));
          }
          else {
            emit(UserErrorState(useApi.message));
          }
        } else {
          emit(UserErrorState("Falsed Upload : ${uploadResponse.error}"));
        }
      }
      else{
        UpdateUserRequest request = UpdateUserRequest(
            firstName: event.newUser.firstName,
            lastName: event.newUser.lastName,
            email: event.newUser.email,
            phone: event.newUser.phone,
            homeAddress: event.newUser.homeAddress,
            companyAddress: event.newUser.companyAddress,
            avatar: event.newUser.avatar);
        ApiResult useApi = await user.updateUser(
            request, event.user.userID);
        if (useApi.code == 200) {
          emit(UserSuccessState(useApi.message));
        }
        else {
          emit(UserErrorState(useApi.message));
        }
      }
    }
    catch (e) {
      throw Exception("UserBloc_updateUser : $e");
    }
  }

  void _changePassword(ChangePassword event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      UserRepository userRepo = UserRepository();
      ApiResult userApi = await userRepo.getMe();
      UserResponse user = userApi.result;
      ApiResult useApi = await userRepo.changePass(
          user.userID, event.oldPass, event.newPass);
      if (useApi.code == 200) {
        emit(UserSuccessState(useApi.message));
      }
      else {
        emit(UserErrorState(useApi.message));
      }
    }
    catch (e) {
      throw Exception("UserBloc_ChangePassword: $e");
    }
  }

  void _addNewVehicle(AddNewVehicle event, Emitter<UserState> emit) async {
    try {
      VehicleRepository vehicle = VehicleRepository();
      ApiResult useApi = await vehicle.addVehicle(event.vehicle);
      if (useApi.code == 200) {
        emit(UserSuccessState(useApi.message));
      }
      else {
        emit(UserErrorState(useApi.message));
      }
    }
    catch (e) {
      throw Exception("UserBloc_addNewVehicle: $e");
    }
  }

  void _deleteNewVehicle(DeleteVehicle event, Emitter<UserState> emit) async {
    try {
      VehicleRepository vehicle = VehicleRepository();
      ApiResult useApi = await vehicle.deleteVehicle(event.vehicleID);
      if (useApi.code == 200) {
        emit(UserSuccessState(useApi.message));
      }
      else {
        emit(UserErrorState(useApi.message));
      }
    }
    catch (e) {
      throw Exception("UserBloc_deleteNewVehicle: $e");
    }
  }
}