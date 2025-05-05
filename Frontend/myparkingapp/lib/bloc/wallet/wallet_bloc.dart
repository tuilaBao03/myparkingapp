import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/wallet/wallet_event.dart';
import 'package:myparkingapp/bloc/wallet/wallet_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/wallet_repository.dart';
import 'package:myparkingapp/data/request/created_wallet_request.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

import '../../data/repository/user_repository.dart';
import '../../data/response/user_response.dart';

class WalletBloc extends Bloc<WalletEvent,WalletState>{
  WalletBloc():super(WalletInitialState()){
    on<WalletInitialEvent>(_loadWalletScreen);
    on<AddWalletEvent>(_addWallet);
    on<LockWalletEvent>(_lockWallet);
  }


  void _loadWalletScreen( WalletInitialEvent event, Emitter<WalletState> emit) async{
    try{
      emit(WalletLoadingState());
      UserRepository userRepository = UserRepository();
      ApiResult userAPI = await userRepository.getMe();
      UserResponse user =  userAPI.result;
      WalletRepository walletRepository = WalletRepository();
      ApiResult walletAPI = await walletRepository.getWalletByUser(user);
      if(walletAPI.code == 200){
        List<WalletResponse> wallets = walletAPI.result;
        emit(WalletLoadedState(wallets,user));
      }
      else{
        emit(WalletErrorState(walletAPI.message));
      }

    }
    catch(e){
      throw Exception("WalletBloc : _loadWalletScreen : $e");
    }
  }
  void _addWallet(AddWalletEvent event, Emitter<WalletState> emit) async {
    try{
      emit(WalletLoadingState());
      WalletRepository wallet = WalletRepository();

      CreatedWalletRequest create = CreatedWalletRequest(balance: 0, currency: event.currency, name: event.name, userId: event.userId);
      ApiResult walletApi = await wallet.createWallet(create);
      if(walletApi.code == 200){
        emit(WalletSuccessState(walletApi.message));
      }
      else{
        emit(WalletErrorState(walletApi.message));
      }
    }
    catch(e){
      throw Exception("WalletBloc : _addWallet : $e");
    }
  }

  void _lockWallet(LockWalletEvent event, Emitter<WalletState> emit) async {
    try{
      emit(WalletLoadingState());
      emit(WalletSuccessState("active"));
    }
    catch(e){
      throw Exception("WalletBloc : _lockWallet : $e");
    }
  }
}

