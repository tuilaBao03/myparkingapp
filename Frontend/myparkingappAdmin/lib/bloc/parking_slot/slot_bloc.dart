import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_event.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_state.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/parkingSlotRepository.dart';

class  ParkingSlotBloc extends Bloc< ParkingSlotEvent, ParkingSlotState>{
   ParkingSlotBloc():super(ParkingSlotInitial()){
    on<GetParkingSlotByLotIdEvent>(_getParkingSlotByLot);
    on<UpdateParkingSlotEvent>(_updateParkingSlot);

   }
   void _getParkingSlotByLot(GetParkingSlotByLotIdEvent event, Emitter<ParkingSlotState> emit) async{
     emit(ParkingSlotLoadingState());
     try{
      ParkingSlotRepository parkingSlotRepository = ParkingSlotRepository();

       final ApiResult apiResult = await parkingSlotRepository.getParkingSlotByLot(event.lotId.toString());
       if(apiResult.code == 200){

        List<ParkingSlotResponse> parkingSlotResponse = apiResult.result;
        List<SLotByFloor> slotsByFloor = loadDataOnFloor(parkingSlotResponse);
       emit(ParkingSlotLoadedState(slotsByFloor));
       }
       else{
         emit(ParkingSlotErrorState(apiResult.message));
       }
     }catch(e){
       throw Exception("ParkingSlotBloc_getParkingSlotByLot:  $e");
     }
   }}
   void _updateParkingSlot(UpdateParkingSlotEvent event, Emitter<ParkingSlotState> emit) async{
     emit(ParkingSlotLoadingState());
     try{
      ParkingSlotRepository parkingSlotRepository = ParkingSlotRepository();

       final ApiResult result = await parkingSlotRepository.updateParkingSlot(event.parkingSlotId, event.request);
       if(result.code == 200){
         emit(ParkingSlotSuccessState(result.message));
       }else{
         emit(ParkingSlotErrorState(result.message));
       }
     }catch(e){
       emit(ParkingSlotErrorState(e.toString()));
       throw Exception("ParkingSlotBloc_updateParkingSlot:  $e");
     }
   }
 List<SLotByFloor> loadDataOnFloor(List<ParkingSlotResponse> slots) {
  // Dùng RegExp để tách ký tự trong ngoặc làm tên tầng
  RegExp regExp = RegExp(r'\((\w)\)');

  // Lấy danh sách các tên tầng duy nhất
  Set<String> floorSet = slots.map((slot) {
    Match? match = regExp.firstMatch(slot.slotName);
    return match?.group(1) ?? 'Unknown';
  }).toSet();

  // Sắp xếp theo ABC
  List<String> floorNames = floorSet.toList()..sort();

  List<SLotByFloor> data = [];

  for (var name in floorNames) {
    List<ParkingSlotResponse> slot = slots.where((i) {
      Match? match = regExp.firstMatch(i.slotName);
      return match?.group(1) == name;
    }).toList();

    SLotByFloor dataOnFloor = SLotByFloor(name,  floorNames,slot);
    data.add(dataOnFloor);
  }

  return data;
}