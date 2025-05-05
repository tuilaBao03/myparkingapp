import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';

abstract class  InvoiceState{}

class  InvoiceInitial extends InvoiceState{

}

class  InvoiceLoadingState extends InvoiceState{

}

class  InvoiceLoadedState extends InvoiceState{
  List<InvoiceResponse> invoiceList;
  InvoiceLoadedState(this.invoiceList);

}

class  InvoiceErrorState extends InvoiceState{
  String mess;
  InvoiceErrorState(this.mess);
}

class  InvoiceSuccessState extends InvoiceState{
  String mess;
  InvoiceSuccessState(this.mess);


}