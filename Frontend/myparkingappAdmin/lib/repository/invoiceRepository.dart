// ignore_for_file: file_names

import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

class InvoiceRepository {
  Future<ApiResult> getInvoiceByLot(String parkingLotId) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getInvoiceByLot(parkingLotId);

      int code = response.data["code"];
      String mess = response.data["message"];

      if (code == 200) {
        List<InvoiceResponse> invoices = (response.data["result"] as List)
            .map((item) => InvoiceResponse.fromJson(item))
            .toList();

        return ApiResult(code, mess, invoices);
      } else {
        return ApiResult(code, mess, null);
      }
    } catch (e) {
      throw Exception("InvoiceRepository_getInvoiceByLot : $e");
    }
  }

  Future<ApiResult> getAllInvoiceByOwner(String userId) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getAllInvoiceByOwner(userId);
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
      throw Exception("InvoiceRepository_getAllInvoiceByOwner : $e");
    }
  }
    Future<ApiResult> getAllInvoiceByAdmin() async{
    try{
      ApiClient apiClient = ApiClient();

        final response = await apiClient.getAllInvoiceByAdmin();
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
      throw Exception("InvoiceRepository_getAllInvoiceByAdmin: $e");
    }
  }
}