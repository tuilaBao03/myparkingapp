// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_event.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_state.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';

import '../../components/api_result.dart';
import '../../data/repository/slot_repository.dart';
// import 'package:myparkingapp/data/repository/slot_repository.dart';

class LotDetailBloc extends Bloc<LotDetailEvent,LotDetailState>{
  LotDetailBloc():super(LotDetailInitial()){
    on<LotDetailScreenInitialEvent>(_LoadHomeScreen);
  }

  List<DataOnFloor> loadDataOnFloor(List<ParkingSlotResponse> slots) {
    // Dùng RegExp để tách ký tự trong ngoặc làm tên tầng
    RegExp regExp = RegExp(r'\((\w)\)');

    // Lấy danh sách các tên tầng duy nhất
    Set<String> floorSet = slots.map((slot) {
      Match? match = regExp.firstMatch(slot.slotName);
      return match?.group(1) ?? 'Unknown';
    }).toSet();

    // Sắp xếp theo ABC
    List<String> floorNames = floorSet.toList()..sort();

    List<DataOnFloor> data = [];

    for (var name in floorNames) {
      List<ParkingSlotResponse> slot = slots.where((i) {
        Match? match = regExp.firstMatch(i.slotName);
        return match?.group(1) == name;
      }).toList();

      DataOnFloor dataOnFloor = DataOnFloor(name, slot, floorNames);
      data.add(dataOnFloor);
    }

    return data;
  }

  void _LoadHomeScreen(LotDetailScreenInitialEvent event, Emitter<LotDetailState> emit) async {
    SlotRepository slotRepository = SlotRepository();
    emit(LoadingLotDetailState());
    try {
      ApiResult apiResult = await slotRepository.getParkingSlotList(event.parkingLot);
      int code = apiResult.code;
      String mess = apiResult.message;
      if (code == 200) {
        List<ParkingSlotResponse> slots = apiResult.result;
        List<DataOnFloor> data = loadDataOnFloor(slots);

        emit(LoadedLotDetailState(data));
      }
      else {
        emit(LotDetailErrorScreen(mess));
      }
      
    }
    catch (e) {
      Exception("LotDetailBloc : $e");
    }
  }
  }




