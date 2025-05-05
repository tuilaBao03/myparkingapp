// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_slot_request.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class ParkingSlotRepository {
  Future<ApiResult> getParkingSlotByLot(String parkingLotID) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getParkingSlotByLot(parkingLotID);
      int code = response.data["code"];
      String mess = response.data["message"];

      if(code == 200){
        List<ParkingSlotResponse> slots = (response.data["result"] as List)
            .map((item) => ParkingSlotResponse.fromJson(item))
            .toList();
        ApiResult apiResult = ApiResult(
           code, mess, slots
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }      
    }
    catch(e){
      throw Exception("ParkingSlotRepository_getParkingSlotByLot: $e");
    }
  }
Future<ApiResult> updateParkingSlot(String parkingSlotID, UpdateParkingSlotResponse request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateParkingSlot(parkingSlotID,request);
      int code = response.data["code"];
      String mess = response.data["message"];
      if(code == 200){
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(
           code, mess, null
        );
        return apiResult;
      }      
    }
    catch(e){
      throw Exception("ParkingSlotRepository_getParkingSlotByLot: $e");
    }
  }
}