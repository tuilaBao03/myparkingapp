import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';

abstract class  TransactionState{}

class  TransactionInitial extends TransactionState{

}

class  TransactionLoadingState extends TransactionState{

}

class  TransactionLoadedState extends TransactionState{
  List<TransactionResponse> trans;
  TransactionLoadedState(this.trans);

}

class  TransactionErrorState extends TransactionState{
  String mess;
  TransactionErrorState(this.mess);
}

class  TransactionSuccessState extends TransactionState{
  String mess;
  TransactionSuccessState(this.mess);


}