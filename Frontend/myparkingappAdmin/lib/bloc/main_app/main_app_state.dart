// ignore_for_file: file_names, camel_case_types, duplicate_ignore
import 'package:myparkingappadmin/data/dto/response/user_response.dart';


abstract class MainAppState{}

class MainInitial extends MainAppState{}

class MainLoading extends MainAppState{}

class MainAppSuccessState extends MainAppState{
  final String mess;
  MainAppSuccessState(this.mess);
}

class LogoutSuccess extends MainAppState{
}

class MainAppErrorState extends MainAppState{
  final String mess;
  MainAppErrorState(this.mess);
}

class ErrorQrScanner extends MainAppState{
  final String mess;
  ErrorQrScanner(this.mess);
  
}
class SuccessQrScanner extends MainAppState{
  final String mess;
  SuccessQrScanner (this.mess);
  
}

class MainAppLoadedState extends MainAppState{
  final UserResponse userResponse;
  MainAppLoadedState(this.userResponse);
}
