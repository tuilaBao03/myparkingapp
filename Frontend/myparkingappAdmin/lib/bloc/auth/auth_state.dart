
// ignore_for_file: file_names

abstract class AuthState{}

class AuthInitial extends AuthState{

}
class AuthSuccess extends AuthState{
  final String userName;
  AuthSuccess(this.userName);
}

class AuthError extends AuthState{
  final String message;
  AuthError(this.message);
}

class RegisterSuccess extends AuthState{
  final bool isRegis;
  RegisterSuccess(this.isRegis);
}