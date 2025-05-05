// ignore_for_file: constant_identifier_names

import 'package:myparkingappadmin/data/dto/response/discount_response.dart';

class CreateDiscountResquest {
  String discountCode;
  DiscountType discountType;
  double discountValue;
  String description;
  String parkingLotID;

  CreateDiscountResquest({
    required this.discountCode,
    required this.discountType,
    required this.discountValue,
    required this.description,
    required this.parkingLotID
  });

  /// **Chuyển từ `Discount` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "discountCode": discountCode,
      "discountType": discountType == DiscountType.PERCENTAGE ? "PERCENTAGE" : "FIXED",
      "discountValue": discountValue,
      "description": description,
      "parkingLotID": parkingLotID,
      'expiredAt': DateTime.august,
      "maxValue":100
    };
  }

  @override
  String toString() {
    return "discountCode: $discountCode, discountType: $discountType, discountValue: $discountValue";
  }
}