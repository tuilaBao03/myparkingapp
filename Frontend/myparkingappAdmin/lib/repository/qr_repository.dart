import '../data/dto/request/entry_request.dart';
import '../data/network/api_client.dart';
import '../data/network/api_result.dart';

class QrRepository{
  Future<ApiResult> giveQrIntoCode(EntryRequest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveQrIntoCode(request);
      String mess = response.data["message"];
      int code = response.data["code"];
      ApiResult apiResult = ApiResult(
          code, mess, null
      );
      return apiResult;
    }
    catch(e){
      throw Exception("QrRepository_giveQrIntoCode : $e");
    }
  }

  Future<ApiResult> giveQrOutCode(EntryRequest request) async{
    try{
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveQrOutCode(request);
      int code = response.data["code"];
      String mess = response.data["message"];
      ApiResult apiResult = ApiResult(
          code, mess, null
      );
      return apiResult;
    }
    catch(e){
      throw Exception("QrRepository_giveQrOutCode : $e");
    }
  }
}