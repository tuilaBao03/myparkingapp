import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';
import 'package:myparkingapp/data/request/resetPassRequest.dart';
import '../network/api_client.dart';

class AuthRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<ApiResult> login(String username, String password) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.login(username, password);
      if (response.data['code'] == 200) {
        String accessToken = response.data['result']['accessToken'];
        String refreshToken = response.data['result']['refreshToken'];
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'], response.data['result']["authenticated"]);
        if(accessToken !=""&&refreshToken!=""){
          await storage.write(key: 'access_token', value: accessToken);
          await storage.write(key: 'refresh_token', value: refreshToken);
        }
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'], false);
        return apiResult;
      }
    } catch (e) {
      throw Exception("_AuthRepository:login $e");
    }
  }

  Future<ApiResult> register(RegisterUserRequest user) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.register(user);
      if (response.statusCode == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'],'');
        return apiResult;
      }
      else{
        throw Exception("_AuthRepository_register:");
      }
    } catch (e) {
      throw Exception("_AuthRepository_register: $e");
    }
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> refreshAccessToken() async {
    try {
      ApiClient apiClient = ApiClient();
      String? refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return;

      final response = await apiClient.refreshToken(refreshToken);
      if (response.statusCode == 200) {
        String newAccessToken = response.data['access_token'];
        await storage.write(key: 'access_token', value: newAccessToken);
      }
    } catch (e) {
      Exception("Token refresh failed: $e");
    
    }
  }

  Future<ApiResult> giveEmail(String email) async {
    try {
      ApiClient apiClient = ApiClient();
      final response = await apiClient.giveEmail(email);
      if (response.data['code'] == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'],response.data['result']['userToken']);
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'],null);
        return apiResult;
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveEmail: $e");
    }
  }

    Future<ApiResult> giveRePassWord(String newPass, String token) async {
    try {
      
      ApiClient apiClient = ApiClient();
      ResetPassRequest request = ResetPassRequest(newPass, token, hashToUUID(token));
      final response = await apiClient.giveRePassWord(request);
      if (response.data['code'] == 200) {
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'],'');
        return apiResult;
      }
      else{
        ApiResult apiResult = ApiResult(response.data['code'], response.data['message'],'');
        return apiResult;
      }
    } catch (e) {
      throw Exception("_AuthRepository_giveRePassWord: $e");
    }
  }

  Future<void> logout() async {
    try{
      String? accessToken = await getAccessToken();
      ApiClient apiClient = ApiClient();
      final response = await apiClient.logout(accessToken!);
      if(response.data["code"] == 200){
        await storage.delete(key: 'access_token');
        await storage.delete(key: 'refresh_token');
      }
      else{
        throw Exception(response.data["message"]);
      }
    }
    catch(e){
      throw Exception("_AuthRepository_logout: $e");
    }
  }


  String hashToUUID(String input) {
    input = "${input}parkingappBCP";
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    String hex = digest.toString();

    return "${hex.substring(0, 8)}-"
        "${hex.substring(8, 12)}-"
        "${hex.substring(12, 16)}-"
        "${hex.substring(16, 20)}-"
        "${hex.substring(20, 32)}";
  }
}
