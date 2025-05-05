abstract class WalletEvent{}


class GetAllWalletEvent extends WalletEvent{

  GetAllWalletEvent ();
}
class GetWalletByCustomerEvent extends WalletEvent{
  String customerId;
  GetWalletByCustomerEvent(this.customerId);
}
class UnlockOrUnlockWalletEvent extends WalletEvent{
  String walletId;
  bool newState;
  UnlockOrUnlockWalletEvent(this.walletId, this.newState);
}