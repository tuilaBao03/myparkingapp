import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/add_vehicle_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class VehicleRepository{
  Future<ApiResult> addVehicle(CreateVehicleRequest vehicle) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.addVehicle(vehicle);
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
    throw Exception("VehicleRepository_addVehicle: $e");
  }
  }
  Future<ApiResult> deleteVehicle(String vehicleID) async{
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.deleteVehicle(vehicleID);

      // Không cần jsonDecode vì response.data đã là JSON
      Map<String, dynamic> jsonData = response.data;
      int code = jsonData['code'];
      String mess = jsonData['message'];
      return ApiResult(code, mess, "");

  } catch (e) {
    throw Exception("VehicleRepository_deleteVehicle: $e");
  }
}
}