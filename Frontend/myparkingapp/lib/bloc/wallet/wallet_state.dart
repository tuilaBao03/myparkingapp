import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

abstract class WalletState {}

class WalletInitialState extends WalletState{}

class WalletLoadingState extends WalletState{}

class WalletLoadedState extends WalletState{
  UserResponse user;
  List<WalletResponse> wallets;
  WalletLoadedState(this.wallets,this.user);
}

class WalletSuccessState extends WalletState{
  String mess;
  WalletSuccessState(this.mess);

}

class WalletErrorState extends WalletState{
  String mess;
  WalletErrorState(this.mess);
}