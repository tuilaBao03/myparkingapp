// ignore_for_file: non_constant_identifier_names


import 'package:myparkingappadmin/data/dto/response/images.dart';

class CreateParkingOwnerRequest {
  final String username;
  final String password;
  final String lastName;
  final String firstName;
  final String phone;
  final String email;


  CreateParkingOwnerRequest( {
    required this.username,
    required this.password,
    required this.lastName,
    required this.firstName,
    required this.phone,
    required this.email,
  });

  /// **Chuyển từ `User` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'roles': ['PARKING_OWNER']
    };
  }
  @override
  String toString() {
    return 'CreateParkingOwnerRequest(username: $username, password: $password, lastName: $lastName, firstName: $firstName, phone: $phone, email: $email)';
  }

   

}

