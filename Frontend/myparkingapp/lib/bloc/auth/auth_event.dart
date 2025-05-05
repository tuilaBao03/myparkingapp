// ignore_for_file: camel_case_types

import 'package:myparkingapp/data/request/register_user_request.dart';

abstract class AuthEvent {}
class LoginEvent extends AuthEvent{
  String userName;
  String passWord;
  LoginEvent(this.userName,this.passWord);
}

class GetUserEvent extends AuthEvent{
  String userName;
  GetUserEvent(this.userName);
}

class RegisterEvent extends AuthEvent{
  RegisterUserRequest request;

  RegisterEvent(this.request);
}

class giveEmail extends AuthEvent{
  String email;
  giveEmail(this.email);
}
class giveRePassWord extends AuthEvent{
  String password;
  String token;
  giveRePassWord(this.password, this.token);
}

class GotoAcceptLocationScreenEvent extends AuthEvent {

}




