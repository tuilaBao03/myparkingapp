// ignore_for_file: constant_identifier_names

import 'package:myparkingapp/data/response/vehicle_response.dart';

enum SlotStatus {
  AVAILABLE, OCCUPIED, RESERVED
}
class ParkingSlotResponse {
  String slotID;
  String slotName;
  VehicleType vehicleType;
  SlotStatus slotStatus;
  double pricePerHour;
  double pricePerMonth;
  String lotId; // sau bỏ

  ParkingSlotResponse({
    required this.slotID,
    required this.slotName,
    required this.vehicleType,
    required this.slotStatus,
    required this.pricePerHour,
    required this.pricePerMonth,
    required this.lotId,
  });

  // Parse Slot from JSON
  factory ParkingSlotResponse.fromJson(Map<String, dynamic> json) => ParkingSlotResponse(
    slotID: json['slotID'],
    slotName: json['slotName'],
    vehicleType: VehicleType.values.firstWhere((e) => e.name == json['vehicleType']),
    slotStatus: SlotStatus.values.firstWhere((e) => e.name == json['slotStatus']),
    pricePerHour: (json['pricePerHour'] as num).toDouble(),
    pricePerMonth: (json['pricePerMonth'] as num).toDouble(),
    lotId: "",
  );

  @override
  String toString() {
    return 'Slot(slotId: $slotID, slotName: $slotName, vehicleType: $vehicleType, '
        'slotStatus: $slotStatus, pricePerHour: $pricePerHour, '
        'pricePerMonth: $pricePerMonth, lotId: $lotId)';
  }
}
List<ParkingSlotResponse> demoSlots = [
  ParkingSlotResponse(
    slotID: 'S001',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.RESERVED,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', 
  ),
  ParkingSlotResponse(
    slotID: 'S002',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.OCCUPIED,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001', 
  ),
  ParkingSlotResponse(
    slotID: 'S003',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001',
  ),
  ParkingSlotResponse(
    slotID: 'S004',
    slotName: 'Slot A1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001',
  ),
  ParkingSlotResponse(slotID: 'S011',
    slotName: 'Slot A1',
    vehicleType: VehicleType.CAR,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 5.0,
    pricePerMonth: 100.0,
    lotId: 'PL001', 
  ),
  ParkingSlotResponse(
    slotID: 'S012',
    slotName: 'Slot A2',
    vehicleType: VehicleType.CAR,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001',
  ),
  ParkingSlotResponse(
    slotID: 'S005',
    slotName: 'Slot A2',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 2.0,
    pricePerMonth: 50.0,
    lotId: 'PL001',
  ),
  ParkingSlotResponse(
    slotID: 'S006',
    slotName: 'Slot B1',
    vehicleType: VehicleType.MOTORCYCLE,
    slotStatus: SlotStatus.AVAILABLE,
    pricePerHour: 1.0,
    pricePerMonth: 20.0,
    lotId: 'PL001',
  ),
];


class DataOnFloor{
  final String floorName;
  final List<ParkingSlotResponse> lots;
  final List<String> floorNames;

  DataOnFloor(
    this.floorName,this.lots, this.floorNames
    );
}

