// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'discount_response.dart';

class InvoiceOnPage {
  List<InvoiceResponse> invoices;
  int page;
  int pageTotal;

  InvoiceOnPage(this.invoices, this.page, this.pageTotal);
}

List<InvoiceOnPage> invoiceOnPages = [
  InvoiceOnPage(invoicesPage1, 1, 2),
  InvoiceOnPage(invoicesPage2, 2, 2)
];

enum InvoiceStatus { PENDING, PAID, CANCELLED }

class InvoiceResponse {
  String invoiceID;
  double totalAmount;
  InvoiceStatus status;
  String description;
  List<TransactionResponse> transaction;
  DiscountResponse discount;
  String parkingSlotName;
  String parkingLotName;
  VehicleResponse vehicle;
  String userID;
  bool isMonthlyTicket;
  String objectDecrypt;

  InvoiceResponse({
    required this.invoiceID,
    required this.totalAmount,
    required this.status,
    required this.description,
    required this.transaction,
    required this.discount,
    required this.parkingSlotName,
    required this.vehicle,
    required this.userID,
    required this.parkingLotName,
    required this.isMonthlyTicket,
    required this.objectDecrypt
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      invoiceID: json['invoiceId'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: InvoiceStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => InvoiceStatus.PENDING),
      description: json['description'] ?? '',
      transaction: (json['transaction'] as List<dynamic>?)
              ?.map((t) => TransactionResponse.fromJson(t))
              .toList() ??
          [],
      discount: DiscountResponse.fromJson(json['discount'] ?? {}),
      vehicle: VehicleResponse.fromJson(json['vehicle'] ?? {}),
      userID: json['userId'] ?? '',
      parkingSlotName: json['parkingSlotName'] ?? '',
      parkingLotName: json['parkingLotName'] ?? '',
      isMonthlyTicket: json['isMonthlyTicket'] ?? false,
<<<<<<< HEAD
      objectDecrypt:json['objectDecrypt'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      parkingSlotID: json['parkingSlotID']
=======
      objectDecrypt:json['objectDecrypt']?? ''

>>>>>>> main
    );
  }

  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceID, status: $status, description: $description, transaction: $transaction, discount: $discount, parkingSlotName: $parkingSlotName, vehicle: $vehicle, userId: $userID)';
  }
}

DiscountResponse discountSample = DiscountResponse(
  discountId: 'D001',
  discountCode: 'SALE10',
  discountType: DiscountType.PERCENTAGE,
  discountValue: 10.0,
  description: 'Giảm 10% cho khách hàng lần đầu tiên.',
  parkingLotId: '',
  expiredAt: '',
);

VehicleResponse vehicleSample = VehicleResponse(
  vehicleId: "V001",
  vehicleType: VehicleType.CAR,
  licensePlate: "ABC-1234",
  description: "Red Sedan Car",
);

final List<InvoiceResponse> invoicesPage1 = [
  InvoiceResponse(
    invoiceID: "INV001",
    status: InvoiceStatus.PAID,
    description: "Invoice for Top up wallet",
    transaction: [transactions[0]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 100.0,
    parkingSlotName: 'Slot A1',
    parkingLotName: 'Lot 1',
    isMonthlyTicket: false, objectDecrypt: 'INV001',
  ),
  InvoiceResponse(
    invoiceID: "INV002",
    status: InvoiceStatus.PENDING,
    description: "Invoice for Payment for order #1234",
    transaction: [transactions[1]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 150.0,
    parkingSlotName: 'Slot B2',
    parkingLotName: 'Lot 2',
    isMonthlyTicket: false, objectDecrypt: 'INV002',
  ),
];

final List<InvoiceResponse> invoicesPage2 = [
  InvoiceResponse(
    invoiceID: "INV003",
    status: InvoiceStatus.CANCELLED,
    description: "Invoice for Top up bonus",
    transaction: [transactions[2]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 200.0,
    parkingSlotName: 'Slot C3',
    parkingLotName: 'Lot 3',
    isMonthlyTicket: true, objectDecrypt: 'INV003',
  ),
  InvoiceResponse(
    invoiceID: "INV004",
    status: InvoiceStatus.PAID,
    description: "Invoice for Payment for order #5678",
    transaction: [transactions[3]],
    discount: discountSample,
    vehicle: vehicleSample,
    userID: "U001",
    totalAmount: 180.0,
    parkingSlotName: 'Slot D4',
    parkingLotName: 'Lot 4',
    isMonthlyTicket: false, objectDecrypt: 'INV004',
  ),
];
