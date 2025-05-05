// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:myparkingappadmin/repository/authRepository.dart';

class DioClient {
  final Dio dio = Dio();
  final AuthRepository authRepository = AuthRepository();

  DioClient() {
    dio.options.baseUrl = "http://192.168.43.152:8080/myparkingapp/";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print(obj),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        try {
          String? token = authRepository.getToken('access_token'); // Dùng hàm getToken()
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          print("Error getting access token: $e");
        }
        handler.next(options);
      },

      onError: (DioException err, ErrorInterceptorHandler handler) async {
        try {
          if (err.response?.data != null &&
              err.response?.data["code"] == 1010) {
            print("Token expired. Attempting to refresh...");

            await authRepository.refreshAccessToken();
            String? newToken = authRepository.getToken('access_token');

            if (newToken != null) {
              final requestOptions = err.requestOptions;
              requestOptions.headers['Authorization'] = 'Bearer $newToken';

              final clonedResponse = await dio.request(
                requestOptions.path,
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                ),
              );
              return handler.resolve(clonedResponse);
            }
          }
        } catch (e) {
          print("Error during token refresh: $e");
        }
        handler.next(err); // Nếu không refresh được thì vẫn đẩy lỗi
      },
    ));
  }
}
