// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_event.dart';
import 'package:myparkingapp/bloc/transaction/transaction_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/screens/dashboard/component/chard.dart';
import 'package:myparkingapp/screens/dashboard/component/filter.dart';
import '../../constants.dart';

class DashBoardScreen extends StatefulWidget {
  final UserResponse user;

  const DashBoardScreen({super.key, required this.user});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<TransactionResponse> trans = [];
  TransactionType type = TransactionType.PAYMENT;
  bool _fillScreen = false;
  int size = 100;

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(
        LoadAllTransactionByTimeEvent(widget.user,size));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.greenAccent,
              size: 25,
            ),
          );
        } else if (state is TransactionDashboardLoadedState) {
          trans = state.trans;
<<<<<<< HEAD
          size = state.size;
=======
          type = state.type;
>>>>>>> main
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate("Deposit Management").toUpperCase()),
              actions: [
                
                IconButton(
                  onPressed: () {
                    setState(() {
                      _fillScreen = !_fillScreen;
                    });
                  },
                  icon: Icon(Icons.filter_list),
                ),
              ],
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
            body: Stack(
              
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/background_invoice.png", // Đường dẫn đến GIF trong thư mục assets
                    fit: BoxFit.cover,
                  ),
                ),
                      // Nội dung chính (Biểu đồ)
                Column(
                  children: [
                    SizedBox(height: defaultPadding*3),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 8),

                      decoration: BoxDecoration(
                        
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text(AppLocalizations.of(context).translate("Deposit Management"),style:Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),

                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      height: Get.width,
                      child: BarChartWidget(
                        data: trans,
                        type: type,
                      ),
                    ),
                  ],
                ),

                // Bộ lọc có hiệu ứng trượt xuống
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: _fillScreen ? 0 : -250, // Trượt xuống khi mở, trượt lên khi đóng
                  left: 0,
                  right: 0,
                  child: FilterTransactionDBoard(tran:trans, userResponse: widget.user, size: size,

                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.greenAccent,
            size: 18,
          ),
        );
      },
      listener: (context, state) {
        if (state is TransactionErrorState) {
          AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess),onPress: (){
            context.read<TransactionBloc>().add(
                LoadAllTransactionByTimeEvent(widget.user,size));
          });
        }
      },
    );
  }
}
