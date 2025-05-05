// ignore_for_file: non_constant_identifier_names

import 'package:myparkingappadmin/data/dto/response/images.dart';

enum UserStatus { ACTIVE, INACTIVE, DELETED }

class UserResponse {
  final String userId;
  final String username;
  final String phone;
  final String homeAddress;
  final String companyAddress;
  final String lastName;
  final String firstName;
  final Images avatar;
  final String email;
  final UserStatus status;
  final List<String> roles;

  UserResponse({
    required this.userId,
    required this.username,
    required this.phone,
    required this.homeAddress,
    required this.companyAddress,
    required this.lastName,
    required this.firstName,
    required this.avatar,
    required this.email,
    required this.status,
    required this.roles,
  });
  UserResponse.empty({
  this.userId = '',
  this.username = '',
  this.phone = '',
  this.homeAddress = '',
  this.companyAddress = '',
  this.lastName = '',
  this.firstName = '',
  Images? avatar,
  this.email = '',
  this.status = UserStatus.INACTIVE,
  this.roles = const [],
}) : avatar = avatar ?? Images('', '', null);

  /// **Chuyển từ JSON sang `UserResponse` object**
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json["userID"] as String? ?? '',
      username: json["username"] as String? ?? '',
      phone: json["phone"] as String? ?? '', // ✅ sửa từ phoneNumber → phone
      homeAddress: json["homeAddress"] as String? ?? '',
      companyAddress: json["companyAddress"] as String? ?? '',
      lastName: json["lastName"] as String? ?? '',
      firstName: json["firstName"] as String? ?? '',
      avatar: json["image"] != null
          ? Images.fromJson(json["image"])
          : Images("", "", null),
      email: json["email"] as String? ?? '',
      status: _parseUserStatus(json["status"] as String?),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((role) => role['roleName'] as String)
          .toList() ??
          [],
    );
  }



  @override
  String toString() {
    return 'UserResponse{userId: $userId, username: $username, phone: $phone, homeAddress: $homeAddress, companyAddress: $companyAddress, lastName: $lastName, firstName: $firstName, avatar: $avatar, email: $email, status: $status, roles: $roles}';
  }

  /// **Chuyển `String` thành `UserStatus`**
  static UserStatus _parseUserStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "ACTIVE":
        return UserStatus.ACTIVE;
      case "INACTIVE":
        return UserStatus.INACTIVE;
      case "DELETED":
        return UserStatus.DELETED;
      default:
        return UserStatus.INACTIVE; // Giá trị mặc định nếu dữ liệu lỗi
    }
  }
}
