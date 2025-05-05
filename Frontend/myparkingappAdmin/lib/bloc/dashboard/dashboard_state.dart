import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';

abstract class  DashboardState{}

class  DashboardInitial extends DashboardState{

}

class  DashboardLoadingState extends DashboardState{

}

class  DashboardLoadedOwnerState extends DashboardState{
  List<InvoiceResponse> invoices;
  List<ParkingLotResponse> parkingLot;
  DashboardLoadedOwnerState(this.invoices, this.parkingLot);
}
class  DashboardLoadedAdminState extends DashboardState{
  List<InvoiceResponse> invoices;
  List<TransactionResponse> transaction;
  DashboardLoadedAdminState(this.invoices, this.transaction);
}

class  DashboardErrorState extends DashboardState{
  String mess;
  DashboardErrorState(this.mess);
}

class  DashboardSuccessState extends DashboardState{
  String mess;
  DashboardSuccessState(this.mess);
}