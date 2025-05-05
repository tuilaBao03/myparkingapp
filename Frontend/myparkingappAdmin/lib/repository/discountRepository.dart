// ignore_for_file: file_names
import 'package:myparkingappadmin/data/dto/request/owner_request/create_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_discount_request.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class DiscountRepository {
  Future<ApiResult> giveDiscountByParkingLot(String slotId) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getListDiscountByLot(slotId);

      int code = response.data["code"];
      String mess = response.data["message"];

      if (code == 200) {
        // Chuyển dữ liệu JSON thành danh sách DiscountResponse
        List<DiscountResponse> discounts = (response.data["result"] as List)
            .map((item) => DiscountResponse.fromJson(item))
            .toList();

        return ApiResult(code, mess, discounts);
      } else {
        return ApiResult(code, mess, null);
      }
    } catch (e) {
      throw Exception("DiscountRepository_giveDiscountByParkingLot : $e");
    }
  }
  Future<ApiResult> createDiscount(CreateDiscountResquest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.createDiscount(request);
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
      throw Exception("DiscountRepository_createDiscount: $e");
    }
  }
  Future<ApiResult> updateDiscount(UpdateDiscountResquest request, String discountId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.updateDiscount( discountId, request);
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
      throw Exception("DiscountRepository_updateDiscount: $e");
    }
  }
  Future<ApiResult> deleteDiscount(String discountId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.deleteDiscount(discountId);
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
      throw Exception("DiscountRepository_deleteDiscount: $e");
    }
  }
}