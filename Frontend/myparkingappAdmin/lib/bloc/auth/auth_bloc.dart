// ignore_for_file: avoid_print, non_constant_identifier_names, file_names, unused_local_variable


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';

import '../../repository/authRepository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthInitial()){
    on<AuthenticateEvent>(_Authenticate);
    // on<ForgetPassWordEvent>(_CheckAndChangePass);
  }
  void _Authenticate(AuthenticateEvent event,Emitter<AuthState> emit) async{
    try{
      AuthRepository auth = AuthRepository();
      ApiResult result = await auth.login(event.username, event.password);
      if(result.code == 200 || result.code == 0){
        emit(AuthSuccess(event.username));
      }
      else{
        emit(AuthError(result.message));
      }
    }
    catch(e){
      print("AuthBloc_Authenticate: $e");
      return null;
    }
    return null;
  }
}