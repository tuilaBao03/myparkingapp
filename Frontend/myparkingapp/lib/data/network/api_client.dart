import 'package:dio/dio.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';
import 'package:myparkingapp/data/request/resetPassRequest.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/add_vehicle_request.dart';
import 'package:myparkingapp/data/response/monthly_ticket_response.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'dio_client.dart';

class ApiClient {
  
    //----------------------------- USER --------------------------------//

  Future<Response> login(String username, String password) async {
    final DioClient dioClient = DioClient();

    return await dioClient.dio.post(
      "auth/login",
      data: {"username": username, "password": password},
    );
  }
  Future<Response> logout(String accessToken) async {
    final DioClient dioClient = DioClient();

    return await dioClient.dio.post(
      "auth/logout",
      data: {"token": accessToken},
    );
  }

  Future<Response> register(
    RegisterUserRequest user
    ) async {
      final DioClient dioClient = DioClient();
      return await dioClient.dio.post(
        "auth/register",
        data:user.toJson(),
      );
    }

  Future<Response> giveEmail(
    String gmail,
    ) async {
      final DioClient dioClient = DioClient();

      return await dioClient.dio.post(
        "auth/forgot-password",
        data: {
          "email": gmail,
        },
      );
    }
  Future<Response> giveRePassWord(ResetPassRequest request) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "auth/reset-password",
       data: request.toJson()
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/refresh",
      data: {"refreshToken": refreshToken},
    );
  }

  Future<Response> getMe() async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/users/profile",
    );
  }
  Future<Response> getUserById(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "/users/id/$userId",
    );
  }

  Future<Response> updateUser(UpdateUserRequest user, String userID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "/users/$userID",
      data:user.toJson(),
    );
  }

  Future<Response> getInvoiceByUserWithSearchAndPage(String search,int page,String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "users/$userId/invoice/search/$search/page/$page",
    );
  }

  Future<Response> getWalletByUser(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "wallets/user/$userId",
    );
  }



  Future<Response> changePassWord(String userID, String oldPass, String newPass) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/user/$userID/updatePass",
      data:{
        'userID':userID,
        'oldPassWord':oldPass,
        'newPassWord':newPass
      },
    );
  }
  
  
  //----------------------------- PARKINGLOT--------------------------------//

  Future<Response> getParkingLotBySearchAndPage(String search,int page,int size) async {
    print("________________________________3_____________________");
    final DioClient dioClient = DioClient();
    print("________________________________4_____________________");
    return await dioClient.dio.get(
      "parkinglots/search?name=$search&page=${page-1}&size=$size",
    );
  }

  Future<Response> getNearParkingLot(Coordinates coordinate) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkingLot/nearby?lat=${coordinate.latitude}&?lon=${coordinate.longitude}",
    );
  }


  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingLotID/parkingslots",
    );
  }

  Future<Response> getListDiscountByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingLotID/discounts",
    );
  }


  //-------------------------SLOT-----------------------------------//



  //-------------------------INVOICE-----------------------------------//

  Future<Response> invoiceCreatedDaily(InvoiceCreatedDailyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "invoices/daily/deposit",
      data:invoice.toJson()

    );
  }
  Future<Response> paymentDaily(PaymentDailyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
        "invoices/daily/payment",
        data:invoice.toJson()

    );
  }
  Future<Response> invoiceCreatedMonthly(InvoiceCreatedMonthlyRequest invoice) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
        "invoices/monthly",
        data:invoice.toJson()

    );
  }

<<<<<<< HEAD
  Future<Response> returnCurrentInvoice(String userID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
        "invoices/active/$userID",
    );
  }

  Future<Response> getInvoiceByID(String invoiceID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "invoices/$invoiceID",
    );
  }

=======
>>>>>>> main
  //--------------------------WALLET------------------------------------//


  Future<Response> createWallet(CreatedWalletRequest wallet) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "wallets",
      data:wallet.toJson()

    );
  }

  Future<Response> unlockOrUnlockWallet(String walletId, bool newState) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch(
      "wallets",
      data:{
        'walletId': walletId,
        'newState': newState,
      }
    );
  }

  Future<Response> topUp(TopUpRequest request) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
        "wallets/top-up",
        data:request.toJson()
    );
  }



  //--------------------------Vehicle-----------------------------//

  Future<Response> addVehicle(CreateVehicleRequest request) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "vehicles",
      data:request.toJson(),
    );
  }

  Future<Response> deleteVehicle(String vehicleID) async{
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch(
      "vehicles/$vehicleID",
    );
  }

  Future<Response> getApiCloud() async{
    final DioClient dioClient = DioClient();
    // Tạo URL động tùy theo tham số truyền vào
    String url = "getAPICLoundinary";
    return await dioClient.dio.get(url);
  }

  Future<Response> getError() async{
    final DioClient dioClient = DioClient();
    String url = "auth/error";
    return await dioClient.dio.get(url);
  }

<<<<<<< HEAD
//--------------------------Transaction-----------------------------//

  Future<Response> getTransactionsByUser({
    required String userID,
    required int size
  }) async {
    final DioClient dioClient = DioClient();

    String url = "transactions/user/$userID?size=$size";

    return await dioClient.dio.get(url);
  }

  Future<Response> getTransactionsByWallet({
    required String walletID,
    required TransactionType tranType,
    required int page,
    required int size
  }) async {
    final DioClient dioClient = DioClient();

    // Tạo URL động tùy theo tham số truyền vào
    String url = "transactions/wallet/$walletID?type=${tranType.name}&page=${page-1}&size=$size";

    return await dioClient.dio.get(url);
  }
=======
>>>>>>> main



}
