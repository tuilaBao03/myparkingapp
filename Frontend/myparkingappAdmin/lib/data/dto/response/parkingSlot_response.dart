// ignore_for_file: file_names
enum SlotStatus { AVAILABLE, OCCUPIED, RESERVED }

class SLotByFloor {
  String floorName;
  List<String> floorNames;
  List<ParkingSlotResponse> parkingSlots;
  SLotByFloor(this.floorName,this.floorNames,this.parkingSlots);
}

class ParkingSlotResponse {
  String slotId;
  String slotName;
  String vehicleType;   // Loại xe (car, motorbike, etc.)
  SlotStatus slotStatus; // Trạng thái (AVAILABLE, OCCUPIED, RESERVED)
  double pricePerHour;  // Giá theo giờ
  double pricePerMonth; // Giá theo tháng
  String parkingLotId;  // Thuộc bãi đỗ nào

  ParkingSlotResponse({
    required this.slotId,
    required this.slotName,
    required this.vehicleType,
    required this.slotStatus,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.parkingLotId,
  });

  /// **Chuyển từ JSON sang `ParkingSlotResponse` object**
  factory ParkingSlotResponse.fromJson(Map<String, dynamic> json) {
    return ParkingSlotResponse(
      slotId: json["slotId"] ?? '',
      slotName: json["slotName"] ?? '',
      vehicleType: json["vehicleType"] ?? 'car',
      slotStatus: _parseSlotStatus(json["slotStatus"]), // Sửa lỗi parse slotStatus
      pricePerHour: (json["pricePerHour"] ?? 0.0).toDouble(),
      pricePerMonth: (json["pricePerMonth"] ?? 0.0).toDouble(),
      parkingLotId: json["parkingLotId"] ?? '',
    );
  }

  /// **Chuyển từ `ParkingSlotResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "slotId": slotId,
      "slotName": slotName,
      "vehicleType": vehicleType,
      "slotStatus": slotStatus.name, // Chuyển enum thành string
      "pricePerHour": pricePerHour,
      "pricePerMonth": pricePerMonth,
      "parkingLotId": parkingLotId,
    };
  }

  @override
  String toString() {
    return "ParkingSlot(slotId: $slotId, vehicleType: $vehicleType, status: $slotStatus, pricePerHour: $pricePerHour, parkingLotId: $parkingLotId)";
  }

  /// **Hàm hỗ trợ chuyển đổi `slotStatus` từ String sang `SlotStatus`**
  static SlotStatus _parseSlotStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "AVAILABLE":
        return SlotStatus.AVAILABLE;
      case "OCCUPIED":
        return SlotStatus.OCCUPIED;
      case "RESERVED":
        return SlotStatus.RESERVED;
      default:
        return SlotStatus.AVAILABLE; // Giá trị mặc định nếu dữ liệu không hợp lệ
    }
  }
}
