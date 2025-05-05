import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_event.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_state.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/invoiceRepository.dart';
import 'package:myparkingappadmin/repository/parkingLotRepository.dart';
import 'package:myparkingappadmin/repository/transactionRepository.dart';

class  DashboardBloc extends Bloc< DashboardEvent, DashboardState>{
   DashboardBloc():super(DashboardInitial()){
      on<DashboardInitialEvent>(giveDashboardByParkingLot);
   }
   void giveDashboardByParkingLot(DashboardInitialEvent event, Emitter<DashboardState> emit) async {
     try {
      emit(DashboardLoadingState());
      if(event.user.roles.contains("ADMIN")){
        emit(DashboardLoadedAdminState(invoices, transactions));
      }
      else{
        emit(DashboardLoadedOwnerState(invoices, parkingLots));
      }
      
     } catch (e) {
       emit(DashboardErrorState(e.toString()));
     }
    
   }

}