// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/repository/auth_repository.dart';


class DioClient {
  final Dio dio = Dio();

  final AuthRepository authRepository = AuthRepository();

  DioClient() {
    dio.options.baseUrl = "http://192.168.43.152:8080/myparkingapp/";
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
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

    // Interceptor để tự động gắn token
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        String? token = await authRepository.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },

      onError: (DioException err, ErrorInterceptorHandler handler) async {
        if (err.response!.statusCode == 401) {
          print("Token expired, refreshing...");
          await authRepository.refreshAccessToken();
          String? newToken = await authRepository.getAccessToken();

          if (newToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            // Thực hiện lại request sau khi có token mới
            final clonedRequest = await dio.request(
              err.requestOptions.path,
              options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
              ),
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            handler.resolve(clonedRequest);
            return;
          }
        }
        if (err.response?.statusCode == 404 || err.response?.statusCode == 405 ||err.response?.statusCode ==400 ) {
          ApiClient apiClient = ApiClient();
          apiClient.getError();
        }
        handler.next(err);
      },
    ));
  }
}
