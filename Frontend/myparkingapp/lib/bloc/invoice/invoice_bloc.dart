import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/invoice_repository.dart';
import 'package:myparkingapp/data/repository/transaction_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
import 'package:myparkingapp/data/response/invoice_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class InvoiceBloc extends Bloc<InvoiceEvent,InvoiceState>{
  InvoiceBloc():super(InvoiceInitialState()){
    on<InvoiceInitialEvent>(_getInvoiceBySearchAndPage);
    on<CreatedInvoiceEvent>(_createInvoice);
  }
  void _getInvoiceBySearchAndPage (InvoiceInitialEvent event, Emitter<InvoiceState> emit) async{
    try{
      emit(InvoiceLoadingState());
      UserRepository userRepository = UserRepository();
      ApiResult userApi =  await userRepository.getMe();
      UserResponse user = userApi.result;
      InvoiceOnPage invoiceOnPage = invoiceOnPages.firstWhere((i)=>i.page == 1);
      List<InvoiceResponse> invoices = invoiceOnPage.invoices;
      emit(InvoiceLoadedState(invoices, event.page, invoiceOnPage.pageTotal, user));
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }
  }
  void _createInvoice(CreatedInvoiceEvent event, Emitter<InvoiceState> emit) async{
    try{
      emit(InvoiceLoadingState());
      InvoiceRepository invoice = InvoiceRepository();
      late ApiResult invoiceApi;
      invoiceApi = await invoice.createdInvoice(event.invoiceD,event.invoiceM);



      if(invoiceApi.code !=200){
        emit(InvoiceErrorState(invoiceApi.message));
      }
      else{
        emit(InvoiceSuccessState(" ${invoiceApi.message}"));
      }
<<<<<<< HEAD
      else{
        emit(InvoiceErrorState(invoiceApi.message));
      }
    }
    catch(e){
      Exception(e);
    }

  }
  List<Invoice_QR> mapToInvoiceQRList(List<Map<String, String>> rawList) {
    return rawList.map((item) {
      final key = item.keys.first;
      final value = item.values.first;
      return Invoice_QR(key, value);
    }).toList();
  }

  void _getCurrentInvoice(GetCurrentInvoiceEvent event, Emitter<InvoiceState> emit ) async{
    try{
      emit(InvoiceLoadingState());
      InvoiceRepository invoiceRepository = InvoiceRepository();
      ApiResult invoiceApi = await invoiceRepository.getCurrentInvoice(event.userID);
      if(invoiceApi.code ==200){
        InvoiceStorageManager storageManager = InvoiceStorageManager();
        List<String> invoices = invoiceApi.result;
        storageManager.filterCurrentInvoice(invoices);
        List<Map<String, String>> invoicesFromStore = await storageManager.getCurrentInvoiceList();
        print(invoicesFromStore);
        List<Invoice_QR> invoiceQrs = mapToInvoiceQRList(invoicesFromStore);
        emit(GetCurrentInvoiceState(invoices: invoiceQrs));
      }
      else{
        emit(InvoiceErrorState(invoiceApi.message));
      }
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }

  }

  void _getInvoiceByID(GetInvoiceByIDEvent event, Emitter<InvoiceState> emit ) async{
    try{
      emit(InvoiceLoadingState());
      InvoiceRepository invoiceRepository = InvoiceRepository();
      UserRepository userRepository = UserRepository();
      WalletRepository walletRepository = WalletRepository();
      ApiResult invoiceApi = await invoiceRepository.getInvoiceByID(event.invoiceID);
      ApiResult userApi = await userRepository.getMe();
      UserResponse user = userApi.result;
      ApiResult walletApi = await walletRepository.getWalletByUser(user);

      if(invoiceApi.code ==200 && walletApi.code == 200){
        InvoiceResponse invoiceResponse = invoiceApi.result;
        List<WalletResponse> wallets = walletApi.result;
        emit(GetInvoiceByIDState(wallets: wallets, invoice: invoiceResponse));
      }
      else{
        emit(InvoiceErrorState("$invoiceApi.message - $walletApi.message"));
      }
    }
    catch(e){
      Exception("InvoiceBloc _getInvoiceBySearchAndPage : $e");
    }

  }

  void _createdPaymentInvoice(CreatedPaymentInvoiceEvent event, Emitter<InvoiceState> emit) async{
    try{
      emit(InvoiceLoadingState());
      InvoiceRepository invoice = InvoiceRepository();

      ApiResult invoiceApi = await invoice.paymentDaily(event.invoice);

      if(invoiceApi.code ==200){
        InvoiceResponse invoiceResponse = invoiceApi.result;
        InvoiceStorageManager invoiceStorageManager = InvoiceStorageManager();
        invoiceStorageManager.addToCurrentInvoice(invoiceResponse.invoiceID, invoiceResponse.objectDecrypt);
        emit(InvoiceSuccessState(invoiceApi.message));
      }
      else{
        emit(InvoiceErrorState(invoiceApi.message));
      }
=======
>>>>>>> main
    }
    catch(e){
      Exception(e);
    }

  }
}