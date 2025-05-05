import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
class UserResponse {
  final String userID;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String homeAddress;
  final String companyAddress;
  final ImagesResponse avatar;
  final List<VehicleResponse> vehicles;

  UserResponse({
    required this.userID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.homeAddress,
    required this.companyAddress,
    required this.avatar,
    required this.vehicles,

  });

  /// Convert JSON -> User
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userID: json['userID'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String ?? '',
      homeAddress: json['homeAddress'] !=null ? json['homeAddress'] as String : '',
      companyAddress: json['companyAddress'] !=null ? json['companyAddress'] as String :'',
      avatar: json['image'] != null
          ? ImagesResponse.fromJson(json['image'])
          : ImagesResponse("", "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg", null),

      vehicles: (json['vehicles'] as List<dynamic>)
          .map((item) => VehicleResponse.fromJson(item))
          .toList(),
    );
  }

  /// Convert User -> JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'avatar': avatar.toJson(),
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UserResponse{userID: $userID, username: $username, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, homeAddress: $homeAddress, companyAddress: $companyAddress, avatar: $avatar, vehicles: $vehicles}';
  }


}
final UserResponse demoUser = UserResponse(
  userID: "U001",
  username: "john_doe",
  firstName: "John",
  lastName: "Doe",
  email: "john.doe@example.com",
  phone: "+123456789",
  homeAddress: "123 Main Street, Cityville",
  companyAddress: "456 Company Blvd, Worktown",
  avatar: ImagesResponse(
    "",null,null
  ),
  vehicles: vehiclesdemo,
);






