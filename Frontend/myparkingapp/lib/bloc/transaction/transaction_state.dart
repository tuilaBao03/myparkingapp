import 'package:myparkingapp/data/response/transaction_response.dart';

abstract class TransactionState {}
class TransactionLoadedState extends TransactionState{
  List<TransactionResponse> trans;
<<<<<<< HEAD
  TransactionType type;
=======
  DateTime start;
  DateTime end;
  Transactions type;
>>>>>>> main
  int page;
  int pageTotal;
  int size;

  TransactionLoadedState(this.trans, this.type, this.page, this.pageTotal,this.size);

}

class TransactionLoadingState extends TransactionState{

}

class TransactionInitialState extends TransactionState{

}

class TransactionDashboardLoadedState extends TransactionState{
  List<TransactionResponse> trans;
  int size;

  TransactionDashboardLoadedState (this.trans,this.size);

}

class TransactionErrorState extends TransactionState{
  String mess;
  TransactionErrorState(this.mess);
}


