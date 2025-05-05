import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class UserRepository{

  Future<ApiResult> getMe() async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getMe();
    Map<String, dynamic> jsonData = response.data;

    int code = jsonData['code'];
    String mess = jsonData['message'];

    if (code == 200) {
      // Không cần jsonDecode vì response.data đã là JSON

      UserResponse user = UserResponse.fromJson(jsonData['result']);
      return ApiResult(code, mess, user);
    } else {
      return ApiResult(code, mess, null);
    }
  } catch (e) {
    throw Exception("UserRepository_getUserByUserName: $e");
  }

  }

  Future<ApiResult> updateUser(UpdateUserRequest user, String userID) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.updateUser(user,userID);
    Map<String, dynamic> jsonData = response.data;

    int code = jsonData['code'];
    String mess = jsonData['message'];
    if (code == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      return ApiResult(code, mess, null);
    } else {
      return ApiResult(code, mess, null);
    }
  } catch (e) {
    throw Exception("UserRepository_updateUser: $e");
  }

  }
  Future<ApiResult> changePass(String userID, String oldPass, String newPass) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.changePassWord(userID, oldPass, newPass);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['message'];
      return ApiResult(code, mess, '');
    } else {
      throw Exception("UserRepository_changePass");
    }
  } catch (e) {
    throw Exception("UserRepository_changePass: $e");
  }
  }
  Future<ApiResult> getUserById(String userId) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getUserById(userId);

    if (response.statusCode == 200) {
      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;

      int code = jsonData['code'];
      String mess = jsonData['message'];
      UserResponse user = UserResponse.fromJson(jsonData['result']);
      return ApiResult(code, mess, user);
    } else {
      throw Exception("UserRepository_getUserById");
    }
  } catch (e) {
    throw Exception("UserRepository_getUserById: $e");
  }
  

  }






}
