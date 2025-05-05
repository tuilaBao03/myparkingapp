// ignore_for_file: file_names
class UpdateParkingSlotResponse {
  String slotId;
  double pricePerHour;  // Giá theo giờ
  double pricePerMonth; // Giá theo tháng

  UpdateParkingSlotResponse({
    required this.slotId,
    required this.pricePerHour,
    required this.pricePerMonth,
  });

  /// **Chuyển từ `ParkingSlotResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "slotId": slotId,
      "pricePerHour": pricePerHour,
      "pricePerMonth": pricePerMonth,
    };
  }

  @override
  String toString() {
    return "ParkingSlot(slotId: $slotId, pricePerHour: $pricePerHour)";
  }
}
