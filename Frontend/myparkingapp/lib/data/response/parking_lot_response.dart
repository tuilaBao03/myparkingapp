

// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/response/images_response.dart';

class LotOnPage{
  final List<ParkingLotResponse> lots;
  final int page;
  final int pageAmount;
  LotOnPage(this.lots,this.page,this.pageAmount);
}

final List<LotOnPage> demo = [
  LotOnPage(parkingLotsDemoPage1, 1, 3),
  LotOnPage(parkingLotsDemoPage2, 2, 3),
  LotOnPage(parkingLotsDemoPage3, 3, 3),
];
enum LotStatus { ON, OFF, FULL_SLOT}

class ParkingLotResponse {
  String parkingLotID;
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  int totalSlot;
  LotStatus status;
  double rate;
  String description;
  List<ImagesResponse> images;
  String userID;
  ParkingLotResponse({
    required this.parkingLotID,
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlot,
    required this.status,
    required this.rate,
    required this.description,
    required this.images,
    required this.userID
  });

  // Convert from JSON
  factory ParkingLotResponse.fromJson(Map<String, dynamic> json) {
    return ParkingLotResponse(
      parkingLotID: json['parkingLotID'],
      parkingLotName: json['parkingLotName'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      totalSlot: json['totalSlot'],
      status: LotStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
        orElse: () => LotStatus.OFF, // Default nếu không đúng
      ),
      rate: (json['rate'] as num).toDouble(),
      description: json['description'],
      userID: json['userID'],
      images: (json['images' ] as List<dynamic>)
          .map((item) => ImagesResponse.fromJson(item))
          .toList(),


    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'parkingLotID': parkingLotID,
      'parkingLotName': parkingLotName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'totalSlot': totalSlot,
      'status': status.toString().split('.').last,
      'rate': rate,
      'description': description,
      'images': images.map((item) => item.toJson()).toList(),
    };
  }
}

List<ParkingLotResponse> parkingLotsDemoPage1 = [
  ParkingLotResponse(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm DemoPage1',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      ImagesResponse( "",'assets/images/featured _items_1.png',null),
      ImagesResponse( "",'assets/images/featured _items_1.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện DemoPage1',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay DemoPage1',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
];
List<ParkingLotResponse> parkingLotsDemoPage2 = [
  ParkingLotResponse(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm DemoPage2',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện DemoPage2',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay DemoPage2',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
];
List<ParkingLotResponse> parkingLotsDemoPage3 = [
  ParkingLotResponse(
    parkingLotID: 'PL001',
    parkingLotName: 'Bãi xe Trung tâm',
    address: '123 Đường Lê Lợi, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7009,
    totalSlot: 100,
    status: LotStatus.ON,
    rate: 5.0,
    description: 'Bãi đỗ xe gần trung tâm thương mại, an ninh 24/7.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL002',
    parkingLotName: 'Bãi xe Bệnh viện',
    address: '456 Đường Nguyễn Trãi, Quận 5, TP.HCM',
    latitude: 10.7626,
    longitude: 106.6822,
    totalSlot: 50,
    status: LotStatus.FULL_SLOT,
    rate: 4.0,
    description: 'Bãi đỗ xe dành cho bệnh nhân và nhân viên y tế.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
  ParkingLotResponse(
    parkingLotID: 'PL003',
    parkingLotName: 'Bãi xe Sân bay',
    address: 'Sân bay Tân Sơn Nhất, Quận Tân Bình, TP.HCM',
    latitude: 10.8188,
    longitude: 106.6518,
    totalSlot: 200,
    status: LotStatus.OFF,
    rate: 10.0,
    description: 'Bãi đỗ xe sân bay, phù hợp cho gửi dài ngày.',
    images: [
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
      ImagesResponse( "", 'assets/images/featured _items_2.png',null),
    ], userID: '',
  ),
];






