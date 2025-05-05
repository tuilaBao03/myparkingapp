// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/home/home_event.dart';
import 'package:myparkingapp/bloc/home/home_state.dart';
import 'package:myparkingapp/data/repository/lots_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
// import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

import '../../components/api_result.dart';
// import 'package:myparkingapp/data/repository/lots_repository.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc(): super(HomeInitialState()){
    on<HomeInitialEvent>(_LoadHomeScreen);
  }

  void _LoadHomeScreen( HomeInitialEvent event, Emitter<HomeState> emit ) async{
    LotRepository lotRepository = LotRepository();
    UserRepository userRepository = UserRepository();
    try{
      print("________________________________-1_____________________");
      emit(HomeLoadingState());
      print("________________________________0_____________________");
      ApiResult userApi =  await userRepository.getMe();
      UserResponse user = userApi.result;
      print("________________________________2_____________________");
      ApiResult apiResult1 = await lotRepository.getParkingLotBySearchAndPage('', 1,5);

      late ApiResult apiResult2;
      if(event.coordinates != null){
        apiResult2 = await lotRepository.getNearParkingLot(event.coordinates!);
      }
      int code = apiResult1.code;
      String mess = apiResult1.message;
      if(code == 200){
        LotOnPage lotOnPage = apiResult1.result;
        List<ParkingLotResponse> lots = lotOnPage.lots;
        emit(HomeLoadedState(lots, lots,user));
      }
      else {
        emit(HomeErrorState(mess));
      }
    }
    catch(e){
      Exception("_LoadHomeScreen : $e");
    }
  }
}