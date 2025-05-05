import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthInitialState()){
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<giveEmail>(_giveEmail);
    on<giveRePassWord>(_giveRePassWord);
    on<GotoAcceptLocationScreenEvent>(_gotoAcceptLocationScreen);
  }
}

void _login(LoginEvent event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.login(event.userName, event.passWord);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(AuthSuccessState(mess));
  }
  else{
    emit(AuthErrorState(mess));
  }
}

void _register(RegisterEvent event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.register(event.request);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(RegisterSuccessState(mess));
  }
  else{
    emit(RegisterErrorState(mess));
  }
}

void _giveEmail(giveEmail event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.giveEmail(event.email);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(GiveEmailSuccessState(apiResult.result));
  }
  else{
    emit(GiveEmailErrorState(mess));
  }
}

void _giveRePassWord(giveRePassWord event, Emitter<AuthState> emit) async{
  emit(AuthLoadingState());
  AuthRepository auth = AuthRepository();
  ApiResult apiResult = await auth.giveRePassWord(event.password, event.token);
  int code = apiResult.code;
  String mess = apiResult.message;
  if(code == 200){
    emit(GiveRePassSuccessState(mess));
  }
  else{
    emit(GiveRePassErrorState(mess));
  }
}
void _gotoAcceptLocationScreen(GotoAcceptLocationScreenEvent event, Emitter<AuthState> emit) async{
  emit(GotoAcceptLocationScreenState());
}