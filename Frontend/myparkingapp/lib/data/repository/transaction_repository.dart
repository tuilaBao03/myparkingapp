import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class TransactionRepository {
  Future<ApiResult> getTransactionByWalletDateTypePage(
    WalletResponse wallet,
    int page,
    TransactionType tranType,
      int size

  ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactionsByWallet(
        page: page,
        tranType: tranType,
        walletID: wallet.walletId, size: size,
      );
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      if (code == 200) {
        int pageTotal = jsonData['result']['totalPages'];
        List<TransactionResponse> trans =
            (jsonData['result']['content'] as List)
                .map((json) => TransactionResponse.fromJson(json))
                .toList();

        TransactionOnPage result = TransactionOnPage(trans, page, pageTotal);

        ApiResult apiResult = ApiResult(code, mess, result);
        return apiResult;
      } else if(code == 129){
        TransactionOnPage result = TransactionOnPage([], page, 0);
        ApiResult apiResult = ApiResult(code, mess, result);
        return apiResult;
      }
      else{
        {
          ApiResult apiResult = ApiResult(code, mess, null);
          return apiResult;
        }
      }
    } catch (e) {
      throw Exception(
        "TransactionRepository_getTransactionByWalletDateTypePage: $e",
      );
    }
<<<<<<< HEAD
  }

  Future<ApiResult> getTransactionByUserDateTypePage(
    String userID,
      int size
  ) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.getTransactionsByUser(
        userID: userID, size: size,
      );
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      if (code == 200) {
        List<TransactionResponse> trans =
          (jsonData['result']['content'] as List)
            .map((json) => TransactionResponse.fromJson(json))
            .toList();

        ApiResult apiResult = ApiResult(code, mess, trans);
        return apiResult;
      } else {
        ApiResult apiResult = ApiResult(code, mess, null);
        return apiResult;
      }
    } catch (e) {
      throw Exception(
        "TransactionRepository_getTransactionByWalletDateTypePage: $e",
      );
    }
  }


}
=======
}
>>>>>>> main
