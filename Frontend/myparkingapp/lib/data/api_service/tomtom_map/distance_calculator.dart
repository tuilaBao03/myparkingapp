import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class DistanceCalculatorCustom {
  /// Lấy vị trí hiện tại
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Dịch vụ vị trí không khả dụng.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Quyền truy cập vị trí bị từ chối.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Quyền truy cập vị trí bị từ chối vĩnh viễn.");
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Tính khoảng cách giữa hai điểm
  double calculateDistance(LatLng start, LatLng end) {
    final Distance distance = Distance();
    return distance.as(
      LengthUnit.Meter,
      LatLng(start.latitude, start.longitude),
      LatLng(end.latitude, end.longitude),
    );
  }

  /// Tính khoảng cách từ vị trí hiện tại đến endPoint
  Future<double> getDistanceToEndpoint(LatLng endPoint) async {
    try {
      Position currentPosition = await getCurrentLocation();
      LatLng currentLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);

      double distance = calculateDistance(currentLatLng, endPoint);
      return distance/1000;
    } catch (e) {
      throw Exception("Không thể tính khoảng cách: $e");
    }
  }
}
