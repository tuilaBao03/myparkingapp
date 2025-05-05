// ignore_for_file: constant_identifier_names

import 'package:myparkingappadmin/data/dto/response/discount_response.dart';

class UpdateDiscountResquest {
  DiscountType discountType;
  double discountValue;
  String description;

  UpdateDiscountResquest({
    required this.discountType,
    required this.discountValue,
    required this.description,
  });

  /// **Chuyển từ `Discount` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "discountType": discountType == DiscountType.PERCENTAGE ? "PERCENTAGE" : "FIXED",
      "discountValue": discountValue,
      "description": description,
    };
  }

  @override
  String toString() {
    return " discountType: $discountType, discountValue: $discountValue";
  }
}