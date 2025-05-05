// ignore_for_file: file_names

abstract class AuthEvent{}
class AuthenticateEvent extends AuthEvent{
  final String username;
  final String password;
  AuthenticateEvent(this.username,this.password);
}
class ForgetPassWordEvent extends AuthEvent{
  final String email;
  ForgetPassWordEvent(this.email);
}

