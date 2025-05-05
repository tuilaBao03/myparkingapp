
import 'package:myparkingapp/data/network/api_client.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

import '../../components/api_result.dart';
import '../response/parking_slots_response.dart';

class SlotRepository {
  final String apiUrl = "";

  Future<ApiResult> getParkingSlotList(ParkingLotResponse parkingLot) async {
    try {
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getParkingSlotByLot(parkingLot.parkingLotID);
    Map<String, dynamic> jsonData = response.data;

    int code = jsonData['code'];
    String mess = jsonData['message'];

    if (code == 200) {
      // Không cần jsonDecode vì response.data đã là JSON


      // Chuyển 'result' từ JSON thành danh sách Discount
      List<ParkingSlotResponse> slots = (jsonData['result'] as List)
          .map((json) => ParkingSlotResponse.fromJson(json))
          .toList();

      return ApiResult(code, mess, slots);
    } else {
      return ApiResult(code, mess, null);
    }
  } catch (e) {
    throw Exception("LotRepository_getNearParkingLot: $e");
  }
  }


}