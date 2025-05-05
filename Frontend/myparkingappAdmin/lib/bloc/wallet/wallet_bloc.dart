import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_event.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_state.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';
import 'package:myparkingappadmin/repository/walletRepository.dart';

class  WalletBloc extends Bloc< WalletEvent, WalletState>{
   WalletBloc():super(WalletInitial()){
      on<GetAllWalletEvent>(_getAllWallet);
      on<GetWalletByCustomerEvent>(_getWalletByCustomer);
      on<UnlockOrUnlockWalletEvent>(_unlockOrUnlockWallet); 
   }
   void _getAllWallet(GetAllWalletEvent event, Emitter<WalletState> emit) async{
     emit(WalletLoadingState());
     try{
      WalletRepository walletRepository = WalletRepository();
       // Call your repository method here to get all wallets
       final response = await walletRepository.getAllWallet();
       if(response.code == 200){
         List<WalletResponse> walletResponse = response.result;
         emit(WalletLoadedState(walletResponse));
       }else{
         emit(WalletErrorState(response.message));
       }
     }catch(e){
       throw Exception("WalletBloc  _getAllWallet : $e");
     }
   }
   void _getWalletByCustomer(GetWalletByCustomerEvent event, Emitter<WalletState> emit) async{
     emit(WalletLoadingState());
     try{
      WalletRepository walletRepository = WalletRepository();
       // Call your repository method here to get all wallets
       final response = await walletRepository.getWalletByCustomer(event.customerId);
       if(response.code == 200){
         List<WalletResponse> walletResponse = response.result;
         emit(WalletLoadedState(walletResponse));
       }else{
         emit(WalletErrorState(response.message));
       }
     }catch(e){
       throw Exception("WalletBloc _getWalletByCustomer : $e ");
     }

   }
   void _unlockOrUnlockWallet(UnlockOrUnlockWalletEvent event, Emitter<WalletState> emit) async{
     emit(WalletLoadingState());
     try{
      WalletRepository walletRepository = WalletRepository();
       // Call your repository method here to get all wallets
       final response = await walletRepository.unlockOrUnlockWallet(event.walletId, event.newState);
       if(response.code == 200){
         emit(WalletSuccessState(response.message));
       }else{
         emit(WalletErrorState(response.message));
       }
     }catch(e){
       throw Exception("WalletBloc _unlockOrUnlockWallet : $e ");
     }
   }
}