import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/invoice/event.dart';
import 'package:myparkingappadmin/bloc/invoice/state.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/invoiceRepository.dart';

class  InvoiceBloc extends Bloc< InvoiceEvent, InvoiceState>{
   InvoiceBloc():super(InvoiceInitial()){
    on<GetInvoiceByLotEvent>(_getInvoiceByLotEvent);
    on<GetInvoiceBySlotEvent>(_getInvoiceBySlotEvent);
   }
   void _getInvoiceByLotEvent(GetInvoiceByLotEvent event, Emitter<InvoiceState> emit) async{
     emit(InvoiceLoadingState());
     try{
      InvoiceRepository invoiceRepository = InvoiceRepository();
       // Call the repository method to get invoice by lot
       final response = await invoiceRepository.getInvoiceByLot(event.parkingLotId);
       if(response.code == 200){
         emit(InvoiceLoadedState(response.result));
       }
       else{
         emit(InvoiceErrorState(response.message));
       }
     }catch(e){
       emit(InvoiceErrorState(e.toString()));
     }
    emit(InvoiceLoadedState(invoices));
   }
   void _getInvoiceBySlotEvent(GetInvoiceBySlotEvent event, Emitter<InvoiceState> emit) async{
     emit(InvoiceLoadingState());
    //  try{
    //   InvoiceRepository invoiceRepository = InvoiceRepository();
    //    // Call the repository method to get invoice by slot
    //    final response = await invoiceRepository.getInvoiceBySlot(event.parkingSlotId);
    //    if(response.code == 200){
    //      emit(InvoiceLoadedState(response.result));
    //    }
    //    else{
    //      emit(InvoiceErrorState(response.message));
    //    }
    //  }catch(e){
    //    emit(InvoiceErrorState(e.toString()));
    //  }
    emit(InvoiceLoadedState(invoices));
   }
}