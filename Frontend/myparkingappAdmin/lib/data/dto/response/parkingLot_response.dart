// ignore_for_file: file_names
import 'package:myparkingappadmin/data/dto/response/images.dart';

enum LotStatus { ON, OFF, FULL_SLOT }

class ParkingLotResponse {
  String parkingLotId;
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  int totalSlot;
  LotStatus status;
  double rate;
  String description;
  String userId;
  List<Images> images;

  ParkingLotResponse({
    required this.parkingLotId,
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlot,
    required this.status,
    required this.rate,
    required this.description,
    required this.userId,
    required this.images, // ✅ Đừng quên thêm dòng này
  });

  /// **Chuyển từ JSON sang `ParkingLotResponse` object**
  factory ParkingLotResponse.fromJson(Map<String, dynamic> json) {
  return ParkingLotResponse(
    parkingLotId: json["parkingLotID"] ?? '',
    parkingLotName: json["parkingLotName"] ?? '',
    address: json["address"] ?? '',
    latitude: (json["latitude"] ?? 0.0).toDouble(),
    longitude: (json["longitude"] ?? 0.0).toDouble(),
    totalSlot: json["totalSlot"] ?? 0,
    status: _parseLotStatus(json["status"]),
    rate: (json["rate"] ?? 0.0).toDouble(),
    description: json["description"] ?? '',
    userId: json["userId"] ?? '',
    images: (json["images"] as List<dynamic>? ?? [])
        .map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> toJson() {
  return {
    "parkingLotId": parkingLotId,
    "parkingLotName": parkingLotName,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "totalSlot": totalSlot,
    "status": status.name,
    "rate": rate,
    "description": description,
    "userId": userId,
    "images": images.map((img) => img.toJson()).toList(),
  };
}

  @override
  String toString() {
    return "ParkingLot(parkingLotName: $parkingLotName, address: $address, totalSlot: $totalSlot, rate: $rate, images: ${images.length})";
  }

  static LotStatus _parseLotStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "ON":
        return LotStatus.ON;
      case "OFF":
        return LotStatus.OFF;
      case "FULL_SLOT":
        return LotStatus.FULL_SLOT;
      default:
        return LotStatus.OFF;
    }
  }
}
