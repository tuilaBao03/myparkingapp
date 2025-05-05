import 'package:myparkingapp/data/response/user_response.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState{

}

class AuthLoadingState extends AuthState{

}

class AuthLoadedState extends AuthState{
}

class AuthSuccessState extends AuthState{
  final String mess;
  AuthSuccessState(this.mess);
}

class GiveRePassSuccessState extends AuthState{
  final String mess;
  GiveRePassSuccessState(this.mess);
}

class GiveRePassErrorState extends AuthState{
  final String mess;
  GiveRePassErrorState(this.mess);
}

class GiveEmailSuccessState extends AuthState{
  final String mess;
  GiveEmailSuccessState (this.mess);
}

class GiveEmailErrorState extends AuthState{
  final String mess;
  GiveEmailErrorState (this.mess);
}



class AuthErrorState extends AuthState{
  final String mess;
  AuthErrorState(this.mess);
}

class RegisterSuccessState extends AuthState{
  final String mess;
  RegisterSuccessState(this.mess);
}

class RegisterErrorState extends AuthState{
  final String mess;
  RegisterErrorState(this.mess);
}

class GotoAcceptLocationScreenState extends AuthState{
  GotoAcceptLocationScreenState();
}


