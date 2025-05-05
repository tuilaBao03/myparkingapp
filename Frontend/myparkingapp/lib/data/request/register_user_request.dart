class RegisterUserRequest {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;


  RegisterUserRequest({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  /// Convert User -> JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'roles':["USER"]
    };
  }

  @override
  String toString() {
    return 'RegisterUserRequest{username: $username, password: $password, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone}';
  }


}