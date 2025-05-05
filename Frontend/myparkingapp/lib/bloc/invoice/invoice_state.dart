import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

abstract class InvoiceState{

}

class InvoiceInitialState extends InvoiceState{

}

class InvoiceLoadingState extends InvoiceState{

  InvoiceLoadingState();
}

class InvoiceLoadedState extends InvoiceState{
  UserResponse user;
  List<InvoiceResponse> invoices;
  final int page;
  final int pageAmount;
  InvoiceLoadedState(this.invoices,this.page,this.pageAmount,this.user);
}

class NoInvoiceState extends InvoiceState{
}

class InvoiceErrorState extends InvoiceState{
  String mess;
  InvoiceErrorState(this.mess);
}

class InvoiceSuccessState extends InvoiceState{
  String mess;
  InvoiceSuccessState(this.mess);
}