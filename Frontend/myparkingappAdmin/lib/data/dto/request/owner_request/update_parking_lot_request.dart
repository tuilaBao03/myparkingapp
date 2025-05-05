// ignore_for_file: file_names
import 'package:myparkingappadmin/data/dto/response/images.dart';


class UpdateParkingLotRequest {
  String parkingLotName;
  String address;
  double latitude;   // Kinh độ
  double longitude;  // Vĩ độ
  String description;
  List<Images> images;

  UpdateParkingLotRequest({
    required this.parkingLotName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.images,
  });

  /// Chuyển từ object sang JSON
  Map<String, dynamic> toJson() {
    return {
      "parkingLotName": parkingLotName,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "description": description,
      "images": images.map((img) => img.toJson()).toList(), // ✅ Serialize images
    };
  }
}

