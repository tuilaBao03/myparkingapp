import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';

class UpdateUserRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String homeAddress;
  final String companyAddress;
  final ImagesResponse avatar;

  UpdateUserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.homeAddress,
    required this.companyAddress,
    required this.avatar,
  });

  /// Convert User -> JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'avatar': avatar.toJson(),
      'status': "ACTIVE"
    };
  }

  @override
  String toString() {
    return 'UpdateUserRequest{ firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, homeAddress: $homeAddress, companyAddress: $companyAddress, avatar: $avatar}';
  }

  /// Hỗ trợ debug dễ dàng

}