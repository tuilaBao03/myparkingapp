// ignore_for_file: non_constant_identifier_names


import 'package:myparkingappadmin/data/dto/response/images.dart';

class UpdateInfoRequest {
  final String username;
  final String phoneNumber;
  final String homeAddress;
  final String companyAddress;
  final String lastName;
  final String firstName;
  final Images avatar;
  final String email;

  UpdateInfoRequest( {
    required this.username,
    required this.phoneNumber,
    required this.homeAddress,
    required this.companyAddress,
    required this.lastName,
    required this.firstName,
    required this.avatar,
    required this.email,
  });


  /// **Chuyển từ `User` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phoneNumber': phoneNumber,
      'homeAddress': homeAddress,
      'companyAddress': companyAddress,
      'lastName': lastName,
      'firstName': firstName,
      'avatar': avatar.toJson(),
      'email': email,
    };
  }
  @override
  String toString() {
    return "User(username: $username, firstName: $firstName, lastName: $lastName, email: $email)";
  }
}


