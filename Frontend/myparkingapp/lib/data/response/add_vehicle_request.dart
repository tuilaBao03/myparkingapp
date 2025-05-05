// Khai báo enum VehicleType
// ignore_for_file: constant_identifier_names




// Class Vehicle
import 'package:myparkingapp/data/response/vehicle_response.dart';

class CreateVehicleRequest {
  String userId;
  VehicleType vehicleType;
  String licensePlate;
  String description;

  CreateVehicleRequest({
    required this.userId,
    required this.vehicleType,
    required this.licensePlate,
    required this.description,
  });


  // Convert Vehicle object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'vehicleType': vehicleType.name,
      'licensePlate': licensePlate,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Vehicle(vehicleId: $userId, vehicleType: ${vehicleType.name}, licensePlate: $licensePlate, description: $description)';
  }
}

