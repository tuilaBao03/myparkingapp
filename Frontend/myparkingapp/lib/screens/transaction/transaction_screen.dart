import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/bloc/transaction/transaction_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/components/pagination_button.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/screens/transaction/component/transaction_item.dart';
import 'package:myparkingapp/screens/transaction/component/filter_transaction.dart';
import '../../constants.dart';

class TransactionScreen extends StatefulWidget {
  final WalletResponse wallet;

  const TransactionScreen({super.key, required this.wallet});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<TransactionResponse> trans = [];
  int page = 1;
  int pageTotal = 1;
  TransactionType type = TransactionType.PAYMENT;
  bool _fillScreen = false;
  int size = 10;
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadTransactionEvent(widget.wallet, type, page,size));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc,TransactionState>
      (builder: (context,state) {
        if(state is TransactionLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        }
        else if(state is TransactionLoadedState){
          trans = state.trans;
          page = state.page;
          pageTotal = state.pageTotal;
          type = state.type;
<<<<<<< HEAD
          size= state.size;
          return Scaffold(
            appBar: AppBar(
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
                  onPressed: () =>{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WalletScreen()))
                  },
                ),
              ),
=======
          return Scaffold(
            appBar: AppBar(
>>>>>>> main
              title: Text(AppLocalizations.of(context).translate("Your Transactions")),
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    _fillScreen = !_fillScreen;
                  });
                }, icon: Icon(Icons.filter_alt))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: trans.isNotEmpty ?
                  Column(
                    children: [
                      const SizedBox(height: defaultPadding),
                      _fillScreen
                          ?FilterTransaction(type: type, wallet: widget.wallet, page: page,size: size,):
                      const SizedBox(height: defaultPadding),
                      // List of cart items
                      ...List.generate(
                        trans.length,
                            (index) => Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                          child: TransactionItem(tran: trans[index],)
                          ),
                        ),
                      PaginationButtons(page: page, pageTotal: pageTotal, onPageChanged: (newPage) {
                          setState(() {
                            page = newPage;
                            context.read<TransactionBloc>().add(LoadTransactionEvent(widget.wallet, type, page,size));// Gọi hàm search
                          });
                          // Gọi API hoặc cập nhật dữ liệu cho trang mới
                        },)
                    ],
                  ): Center(
                  child: Text(AppLocalizations.of(context).translate("You wasn't any transaction !")),
                ),
              ),
            ),
          );

        }
        return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
    }, listener: (context,state){
        if(state is TransactionErrorState){
          AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess),onPress: (){
            context.read<TransactionBloc>().add(LoadTransactionEvent(widget.wallet, type, page,size));
          });

        }
    });
  }
}



