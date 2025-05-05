import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';

enum VehicleType { MOTORCYCLE, CAR, BICYCLE }

String vehicleTypeToJson(VehicleType type) {
  return type.toString().split('.').last;
}

class VehicleSlotConfig {
  VehicleType type;
  int numberOfSlot;
  double pricePerHour;
  double pricePerMonth;

  VehicleSlotConfig({
    required this.type,
    required this.numberOfSlot,
    required this.pricePerHour,
    required this.pricePerMonth,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': vehicleTypeToJson(type),
      'numberOfSlot': numberOfSlot,
      'pricePerHour': pricePerHour,
      'pricePerMonth': pricePerMonth,
    };
  }
}

class LocationConfig {
  String location;
  int totalSlot;
  List<VehicleSlotConfig> vehicleSlotConfigs;

  LocationConfig({
    required this.location,
    required this.totalSlot,
    required this.vehicleSlotConfigs,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'totalSlot': totalSlot,
      'vehicleSlotConfigs': vehicleSlotConfigs.map((v) => v.toJson()).toList(),
    };
  }
}

class CreateParkingLotRequest {
  String parkingLotName;
  String address;
  double latitude;
  double longitude;
  double rate;
  String description;
  String userID;
  int totalSlot;
  List<Images> images;
  List<LocationConfig> locationConfigs;

  CreateParkingLotRequest({
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.description,
    required this.userID,
    required this.totalSlot,
    required this.images,
    required this.locationConfigs,
  });

  Map<String, dynamic> toJson() {
    return {
      'parkingLotName': parkingLotName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'status': LotStatus.ON,
      'rate': rate,
      'description': description,
      'userID': userID,
      'totalSlot': totalSlot,
      'images': images.map((img) => img.toJson()).toList(),
      'locationConfigs': locationConfigs.map((l) => l.toJson()).toList(),
    };
  }
}
