import '../dto/response/parkingLot_response.dart';
import 'dio_client.dart';
import 'package:dio/dio.dart';
import '../dto/request/entry_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/create_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_lot_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_parking_slot_request.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';

class ApiClient {
  //----------------------------- USER --------------------------------//

  Future<Response> login(String username, String password) async {
    final DioClient dioClient = DioClient();

    return await dioClient.dio.post(
      "auth/login",
      data: {"username": username, "password": password},
    );
  }

  Future<Response> register(CreateParkingOwnerRequest request) async {
    final DioClient dioClient = DioClient();
    print("client app______ : ${request.toString()}");
    print("client app______ : ${request.toJson()}");

    return await dioClient.dio.post("auth/register", data: request.toJson());
  }

  Future<Response> giveEmail(String gmail) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "auth/giveEmail",
      data: {
        "gmail": gmail,
      },
    );
  }

  Future<Response> giveRePassWord(String newPass, String token) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "auth/UpdatePassWord",
      data: {
        "acceptToken": token,
        "password": newPass,
      },
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "/refresh-token",
      data: {"refresh_token": refreshToken},
    );
  }

  Future<Response> getMe() async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "users/profile",
    );
  }

  Future<Response> getAllUser() async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "users",
    );
  }

  Future<Response> updateUser(UpdateInfoRequest user, String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "users/$userId/update",
      data: {user.toJson()},
    );
  }

  Future<Response> updateStatusUser(UserStatus newStatus, String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "user/$userId/update",
      data: {"newStatus": newStatus},
    );
  }

  Future<Response> changePassWord(
      String userId, String oldPass, String newPass) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "user/$userId/updatePass",
      data: {'userId': userId, 'oldPassWord': oldPass, 'newPassWord': newPass},
    );
  }

  //----------------------------- PARKING--------------------------------//
  Future<Response> updateStatusParkingLot(
      LotStatus newStatus, String parkingLotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put(
      "user/$parkingLotId/update",
      data: {"newStatus": newStatus},
    );
  }

  Future<Response> getParkingLotByOwner(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/user/$userId",
    );
  }

  Future<Response> updateParkingLot(
      String parkingLotId, UpdateParkingLotRequest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put("parkinglots/$parkingLotId/update", data:  request.toJson(),
);
  }

  Future<Response> createParkingLot(CreateParkingLotRequest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post("parkinglot", data:  request.toJson(),
    );
  }
  //--------------------------PARKING SLOT------------------------------------//

  Future<Response> getParkingSlotByLot(String parkingLotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingLotID/parkingslots",
    );
  }

  Future<Response> updateParkingSlot(
      String parkingSlotID, UpdateParkingSlotResponse request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put("parkingSlot/$parkingSlotID/update", data: {
      'parkingSlot': request.toJson(),
    });
  }

  //--------------------------DISCOUNT------------------------------------//

  Future<Response> createDiscount(CreateDiscountResquest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post("discount", data: {
      "discount": request.toJson(),
    });
  }

  Future<Response> updateDiscount(
      String discountId, UpdateDiscountResquest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.put("discount/$discountId/update",
        data: request.toJson(),
    );
  }

  Future<Response> getListDiscountByLot(String parkingSlotID) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglots/$parkingSlotID/discounts",
    );
  }

  Future<Response> deleteDiscount(String discountId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.delete(
      "discounts/$discountId",
    );
  }

  //--------------------------INVOICE------------------------------------//

  Future<Response> getAllInvoiceByOwner(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get("user/$userId/invoice");
  }

  Future<Response> getAllInvoiceByAdmin() async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "invoice",
    );
  }

  Future<Response> getInvoiceBySlot(String parkingSlotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglot/$parkingSlotId/invoice",
    );
  }

  Future<Response> getInvoiceByLot(String parkingLotId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get(
      "parkinglot/$parkingLotId/invoice",
    );
  }
  //--------------------------WALLET------------------------------------//

  Future<Response> getAllWallet() async {
    final DioClient dioClient = DioClient();

    // Tạo URL động tùy theo tham số truyền vào
    String url = "wallet";
    return await dioClient.dio.get(url);
  }

  Future<Response> unlockOrUnlockWallet(String walletId, bool newState) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.patch("wallet", data: {
      'walletId': walletId,
      'newState': newState,
    });
  }

  Future<Response> getWalletByCustomer(String userId) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.get("wallets/user/$userId");

  }

  //--------------------------TRANSACTION------------------------------------//

  Future<Response> getTransactionsByWallet(
    String walletId,
  ) async {
    print("___________________________________________");
    final DioClient dioClient = DioClient();
    // Tạo URL động tùy theo tham số truyền vào
    String url = "transactions/wallet/$walletId?type=PAYMENT&page=0&size=100";

    return await dioClient.dio.get(url);
  }

  Future<Response> getAllTransaction() async {
    final DioClient dioClient = DioClient();

    // Tạo URL động tùy theo tham số truyền vào
    String url = "transactions/all";

    return await dioClient.dio.get(url);
  }

  //--------------------------Image------------------------------------//
  Future<Response> getApiCloud() async {
    final DioClient dioClient = DioClient();
    // Tạo URL động tùy theo tham số truyền vào
    String url = "getAPICLoundinary";
    return await dioClient.dio.get(url);
  }

  Future<Response> giveQrIntoCode(EntryRequest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "entry/enter",
      data: request.toJson(), // chuẩn bị thành Map rồi truyền
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  Future<Response> giveQrOutCode(EntryRequest request) async {
    final DioClient dioClient = DioClient();
    return await dioClient.dio.post(
      "entry/leave",
      data: request.toJson(),
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }
}
