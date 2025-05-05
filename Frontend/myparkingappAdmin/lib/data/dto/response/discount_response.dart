// ignore_for_file: constant_identifier_names

enum DiscountType { PERCENTAGE, FIXED }

class DiscountResponse {
  String discountId;
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;
  String parkingLotId;

  DiscountResponse({
    required this.discountId,
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
    required this.parkingLotId,
  });

  /// **Chuyển từ JSON sang `Discount` object**
  factory DiscountResponse.fromJson(Map<String, dynamic> json) {
    return DiscountResponse(
      discountId: json["discountId"] ?? '',
      discountCode: json["discountCode"] ?? '',
      discountType: json["discountType"] == "PERCENTAGE" ? DiscountType.PERCENTAGE : DiscountType.FIXED,
      discountValue: (json["discountValue"] ?? 0).toDouble(),
      description: json["description"] ?? '',
      parkingLotId: json["parkingLotId"] ?? '',
    );
  }
  /// **Chuyển từ `Discount` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "discountId": discountId,
      "discountCode": discountCode,
      "discountType": discountType == DiscountType.PERCENTAGE ? "PERCENTAGE" : "FIXED",
      "discountValue": discountValue,
      "description": description,
      "parkingLotId": parkingLotId,
    };
  }

  @override
  String toString() {
    return "Discount(discountId: $discountId,"
        " discountCode: $discountCode, discountType: $discountType, discountValue: $discountValue, parkingLotId: $parkingLotId)";
  }
}
