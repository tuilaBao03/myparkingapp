abstract class TransactionEvent{}


class GetTransactionsByWalletEvent extends TransactionEvent{
  String walletID;
  GetTransactionsByWalletEvent(this.walletID);
}

class GetTransactionsByParkingLotEvent extends TransactionEvent{
  String parkingLotID;
  GetTransactionsByParkingLotEvent(this.parkingLotID);
}