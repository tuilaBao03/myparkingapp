// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/wallet/wallet_bloc.dart';
import 'package:myparkingapp/bloc/wallet/wallet_event.dart';
import 'package:myparkingapp/bloc/wallet/wallet_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/api_service/vn_pay/vn_pay_service.dart';

import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/screens/transaction/transaction_screen.dart';
import 'package:myparkingapp/screens/wallet/component/wallet_item.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<WalletResponse> wallets = [];
  UserResponse user = demoUser;
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(WalletInitialEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("My Wallet")),
        backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ),
      body: BlocConsumer<WalletBloc,WalletState>(
        builder: (context,state){
          if(state is WalletLoadingState){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
          }
          else if(state is WalletLoadedState){

            wallets = state.wallets;
            user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  if (wallets.isEmpty)
                    Text(
                      AppLocalizations.of(context)
                          .translate("You don't have any wallets. Create a wallet to continue our trip"),
                      textAlign: TextAlign.center,
                    )
                  else
                    Column(
                      children: wallets
                          .map((wallet) => WalletItem(
                                 // Đảm bảo có thuộc tính money
                                detailCard: () => AppDialog.showDetailWallet(context,wallet),
                                showTransaction: ()=>{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionScreen(wallet: wallet)))
                                },
                                depositMoney: (WalletResponse wallet) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepositFormScreen(walletResponse: wallet, user: user,)));
                                } ,
                                wallet: wallet,
                                lockWallet: (WalletResponse wallet) {
                                  context.read<WalletBloc>().add(LockWalletEvent(wallet.walletId));
                                },
                              ))
                          .toList(),
                    ),

                  ElevatedButton.icon(
                  onPressed: () => _showWalletAdd(context),
                  icon: Icon(Icons.add_circle_outlined),
                  label: Text("Add Wallet"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );

          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);

        },
        listener: (context,state){
          if(state is WalletSuccessState){
            AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess), onPress: (){
              context.read<WalletBloc>().add(WalletInitialEvent());
            });
          }
          else if(state is WalletErrorState){
            AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
          }
        })
    );
  }
  void _showWalletAdd(BuildContext context) {
    TextEditingController name = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("Add Wallet")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: name, decoration: InputDecoration(labelText: "NameWallet")),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<WalletBloc>().add(AddWalletEvent(0, "USD", name.text.trim(), user.userID));
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

}


