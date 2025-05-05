// ignore_for_file: avoid_print, file_names

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/data/dto/request/entry_request.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/repository/imageRepository.dart';
import 'package:myparkingappadmin/repository/qr_repository.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';
import '../../repository/authRepository.dart';
import 'main_app_event.dart';
import 'main_app_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  MainAppBloc() : super(MainInitial()) {
    on<initializationEvent>(_getUserByUserName);
    on<LogoutEvent>(_logout);
    on<UpdatesUserInforEvent>(_updatesUserInfo);
    on<UpdatesPassEvent>(_updatesPass);
    on<ScannerEvent>(_scannerQr);
  }

  void _getUserByUserName(initializationEvent event,
      Emitter<MainAppState> emit) async {
    try {
      final UserRepository userRepository = UserRepository();
      ApiResult userResult = await userRepository.getMe();
      String message = userResult.message;
      int code = userResult.code;
      if (code == 200) {
        emit(
            MainAppLoadedState(userResult.result)
        );
      }
      else {
        emit(MainAppErrorState(message));
      }
    } catch (e) {
      throw Exception ("MainAppBloc_updatedUserInfo $e");
    }
  }

  void _updatesUserInfo(UpdatesUserInforEvent event,
      Emitter<MainAppState> emit) async {
    try {
      ImageRepository imagerepository = ImageRepository();
      Cloudinary cloudinary = await imagerepository.getApiCloud();
      CloudinaryResponse uploadResponse = await imagerepository.uploadImage(
          cloudinary,
          event.request.avatar.imageBytes!,
          "myparkingapp/avatars",
          event.request.avatar.imageID,
          event.request.avatar.imageID);
      if (uploadResponse.isSuccessful) {
        Images image = Images(
            event.request.avatar.imageID, uploadResponse.url, null);
        final UserRepository userRepository = UserRepository();
        UpdateInfoRequest request = UpdateInfoRequest(
            username: event.request.username,
            phoneNumber: event.request.phoneNumber,
            homeAddress: event.request.homeAddress,
            companyAddress: event.request.companyAddress,
            lastName: event.request.lastName,
            firstName: event.request.firstName,
            avatar: image,
            email: event.request.email);
        ApiResult userResult = await userRepository.updatedUser(
            request, event.userId);
        String message = userResult.message;
        int code = userResult.code;
        if (code == 200) {
          emit(
              MainAppSuccessState(message)
          );
        }

        else {
          emit(MainAppErrorState(message));
        }
        emit(MainAppSuccessState(
            "Successful Upload"));
      } else {
        emit(MainAppErrorState(
            "Failed Upload : ${uploadResponse.error}"));
      }
    } catch (e) {
      throw Exception ("MainAppBloc_updatedUserInfo $e");
    }
  }

  void _updatesPass(UpdatesPassEvent event, Emitter<MainAppState> emit) async {
    try {
      final UserRepository userRepository = UserRepository();
      ApiResult userResult = await userRepository.changePassWord(
          event.userId, event.olderPass, event.newPass);
      String message = userResult.message;
      int code = userResult.code;
      if (code == 200) {
        emit(MainAppSuccessState(message));
      } else {
        emit(MainAppErrorState(message));
      }
    } catch (e) {
      throw Exception ("MainAppBloc_updatesPass $e");
    }
  }

  void _scannerQr(ScannerEvent event, Emitter<MainAppState> emit) async {
    try {
      QrRepository qrs = QrRepository();
      EntryRequest request = EntryRequest(event.qrString);
      late ApiResult qr;
      if (event.isEntry) {
        qr = await qrs.giveQrIntoCode(request);
      }
      else {
        qr = await qrs.giveQrOutCode(request);
      }
      if (qr.code == 200) {
        SuccessQrScanner("WELCOME");
      }
      else {
        ErrorQrScanner("SORRY, YOUR QR MAY BE EXPIRED");
      }
    } catch (e) {
      print("_updatedUserInfo $e");
    }
  }

  void _logout(LogoutEvent event, Emitter<MainAppState> emit) async {
    final AuthRepository userRepository = AuthRepository();
    userRepository.logout();
    emit(LogoutSuccess());
  }
}
