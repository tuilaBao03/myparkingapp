// ignore_for_file: file_names
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class ParkingLotRepository {
  Future<ApiResult> getParkingLotByOwner(String userId) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getParkingLotByOwner(userId);

      int code = response.data["code"];
      String mess = response.data["message"];

      // Chuyển response thành danh sách ParkingResponse
      List<ParkingLotResponse> parkings = (response.data["result"] as List)
          .map((item) => ParkingLotResponse.fromJson(item))
          .toList();

      // Trả về ApiResult với dữ liệu
      return ApiResult(code, mess, code == 200 ? parkings : null);
    } catch (e) {
      throw Exception("ParkingLotRepository_getParkingLotByOwner : $e");
    }
  }
  Future<ApiResult> updateStatusParkingLot(LotStatus newStatus, String parkingLotId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateStatusParkingLot(newStatus, parkingLotId);
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
      throw Exception("ParkingLotRepository_updateStatusParkingLot: $e");
    }
  }
  Future<ApiResult> updateParkingLot(String parkingLotId, UpdateParkingLotRequest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateParkingLot(parkingLotId,request);
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
      throw Exception("ParkingLotRepository_updateStatusParkingLot: $e");
    }
  }
  Future<ApiResult> createParkingLot(CreateParkingLotRequest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.createParkingLot(request);
      int code = response.data["code"];
      String mess = response.data["message"];
      if(code== 200){
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
      throw Exception("ParkingLotRepository_createParkingLot: $e");
    }
  }



}