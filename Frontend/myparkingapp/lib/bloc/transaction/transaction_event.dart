import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

abstract class TransactionEvent {}

class LoadTransactionEvent extends TransactionEvent{
  WalletResponse wallet;
  int size;
  TransactionType type;
  int page;
  LoadTransactionEvent(this.wallet, this.type, this.page,this.size);
}


class LoadAllTransactionByTimeEvent extends TransactionEvent{
  UserResponse userResponse;
  int size;
  LoadAllTransactionByTimeEvent(this.userResponse, this.size);
}

class FilterTransactionByTimeEvent extends TransactionEvent{
  int size;
   TransactionType? type;
   DateTime? start;
   DateTime? end;
  final List<TransactionResponse> tran;

  FilterTransactionByTimeEvent(this.type, this.start, this.end, this.tran,this.size);
}

class ExportExcelEvent extends TransactionEvent{

}

