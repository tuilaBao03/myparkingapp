// ignore_for_file: file_names
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/network/api_client.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';


class TransactionRepository {
  Future<ApiResult> getTransactionsByWallet(
      String walletId, 
    ) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactionsByWallet(
      walletId,
    );
      int code = response.data["code"];
      String mess = response.data["message"];
      if(code == 200){
        List<TransactionResponse> trans = (response.data["result"]["content"] as List)
            .map((item) => TransactionResponse.fromJson(item))
            .toList();
        ApiResult apiResult = ApiResult(
           code, mess, trans
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
      throw Exception("ParkingSlotRepository_getTransactionsByWallet: $e");
    }
  }
  Future<ApiResult> getAllTransactions(
    ) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getAllTransaction();
      int code = response.data["code"];
      String mess = response.data["message"];
      if(code == 200){
                List<TransactionResponse> trans = (response.data["result"]["content"] as List)
            .map((item) => TransactionResponse.fromJson(item))
            .toList();
        ApiResult apiResult = ApiResult(
           code, mess, trans
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
      throw Exception("ParkingSlotRepository_getAllTransactions: $e");
    }
  }
}