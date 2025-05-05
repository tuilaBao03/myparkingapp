

import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';


class WalletRepository{
  Future<ApiResult> getWalletByUser(UserResponse user) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getWalletByUser(user.userID);
    Map<String, dynamic> jsonData = response.data;

    int code = jsonData['code'];
    String mess = jsonData['message'];

    if (code == 200) {

      List<WalletResponse> wallets = (jsonData['result'] as List)
          .map((json) => WalletResponse.fromJson(json))
          .toList();
      return ApiResult(code, mess, wallets);
    } else {
      return ApiResult(code, mess, null);
    }
  } catch (e) {
    throw Exception("WalletRepository_getWalletByUser: $e");
  }

  }
  Future<ApiResult> createWallet(CreatedWalletRequest wallet) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.createWallet(wallet);
    Map<String, dynamic> jsonData = response.data;

    int code = jsonData['code'];
    String mess = jsonData['message'];
    if (code == 200) {

      return ApiResult(code, mess, null);
    } else {
      return ApiResult(code, mess, null);
    }
  } catch (e) {
    throw Exception("WalletRepository_getWalletByUser: $e");
  }

  }
  Future<ApiResult> topUp(
      TopUpRequest request,
      ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.topUp(request);
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      ApiResult apiResult = ApiResult(code, mess, null);
      return apiResult;
    } catch (e) {
      throw Exception("TransactionRepository_topUp: $e");
    }
  }
}