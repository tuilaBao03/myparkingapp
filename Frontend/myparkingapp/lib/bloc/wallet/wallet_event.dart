
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

abstract class WalletEvent {}

class WalletInitialEvent extends WalletEvent{
  WalletInitialEvent();
}

class AddWalletEvent extends WalletEvent{
  double balance;
  String currency;
  String name;
  String userId;
  AddWalletEvent(this.balance,this.currency,this.name,this.userId);

}
class LockWalletEvent extends WalletEvent{
  String walletId;
  LockWalletEvent(this.walletId);
}

