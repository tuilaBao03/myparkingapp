// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class InvoiceCreatedDailyRequest {
  double total;
  String description;
  String? discountCode;
  String parkingSlotID;
  String vehicleID;
  String userID;
  String walletID;

  InvoiceCreatedDailyRequest({
    required this.description,
    this.discountCode,  // discountCode là tùy chọn, có thể là null
    required this.parkingSlotID,
    required this.vehicleID,
    required this.userID,
    required this.walletID,
    required this.total,
  });



  Map<String, dynamic> toJson() {
  return {
    'description': description,
    'discountCode': discountCode,
    'parkingSlotID': parkingSlotID,
    'vehicleID': vehicleID,
    'userID': userID,
    'walletID':walletID
  };
}

  @override
  String toString() {
    return 'CreatedInvoiceRequest{description: $description, discountCode: $discountCode, parkingSlotID: $parkingSlotID, vehicleID: $vehicleID, userID: $userID, walletID: $walletID}';
  }
}

class PaymentDailyRequest {
  String invoiceID;
  String? discountID;  // discountID có thể là null
  String parkingSlotID;
  String walletID;
  double total;

  // Constructor không bắt buộc discountID
  PaymentDailyRequest({
    required this.invoiceID,
    this.discountID,  // discountID là tùy chọn, có thể là null
    required this.parkingSlotID,
    required this.walletID,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'invoiceID': invoiceID,
      'discountID': discountID,  // Nếu discountID là null thì nó sẽ là null trong JSON
      'parkingSlotID': parkingSlotID,
      'walletID': walletID,
      'total': total,
    };
  }

  @override
  String toString() {
    return 'PaymentDailyRequest{invoiceID: $invoiceID, discountID: $discountID, parkingSlotID: $parkingSlotID, walletID: $walletID, total: $total}';
  }
}

class InvoiceCreatedMonthlyRequest {
  String description;
  String? discountCode;
  String parkingSlotID;
  String vehicleID;
  String userID;
  String walletID;
  DateTime startedAt;
  DateTime expiredAt;
  double total;


  InvoiceCreatedMonthlyRequest({
    required this.description,
    this.discountCode,
    required this.parkingSlotID,
    required this.vehicleID,
    required this.userID,
    required this.walletID,
    required this.startedAt,
    required this.expiredAt,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'discountCode': discountCode,
      'parkingSlotID': parkingSlotID,
      'vehicleID': vehicleID,
      'userID': userID,
      'walletID': walletID,
      'startedAt': startedAt.toIso8601String(),
      'expiredAt': expiredAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'InvoiceCreatedMonthlyRequest{description: $description, discountCode: $discountCode, parkingSlotID: $parkingSlotID, vehicleID: $vehicleID, userID: $userID, walletID: $walletID, startedAt: $startedAt, expiredAt: $expiredAt}';
  }
}