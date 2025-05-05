// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/payment/payment_bloc.dart';
import 'package:myparkingapp/bloc/payment/payment_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/api_service/vn_pay/info_vnpay.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class DepositFormScreen extends StatefulWidget {

  final WalletResponse walletResponse;
  final UserResponse user;

  const DepositFormScreen({super.key, required this.walletResponse, required this.user});
  @override
  State<DepositFormScreen> createState() => _DepositFormScreenState();
}
class _DepositFormScreenState extends State<DepositFormScreen> {

  void _submitForm() {
    String name = _nameController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;
    String note = _noteController.text;
    // Thực hiện logic xử lý dữ liệu (ví dụ: gọi API, hiển thị thông báo, v.v.)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate('Confirm Infomation')),
        content: SizedBox(
          width: Get.width,
          height: Get.height/2,
          child: TransactionInfo(name: name, amount: amount, note: note, user: widget.user,)
          ), 
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.cancel, color: Colors.red,))
        ],
      ),
    );
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.walletResponse.name;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
          title: Text(AppLocalizations.of(context).translate('Transaction info')),
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                // ignore: deprecated_member_use
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      body: BlocConsumer<PaymentBloc,PaymentState>(builder: (context,state){
        if(state is PaymentLoadingState ){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        }
        return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Họ và tên
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('wallet name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).translate('Enter wallet name');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Input Số tiền
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('Money'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).translate('Enter money');
                    }
                    if (double.tryParse(value) == null) {
                      return AppLocalizations.of(context).translate('Money not validation');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Input Ghi chú
                TextFormField(
                  controller: _noteController,
                  decoration:  InputDecoration(
                    labelText: AppLocalizations.of(context).translate('Note'),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),

                // Nút xác nhận
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(AppLocalizations.of(context).translate('Accept')),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      }, listener:(context,state) async {
      if(state is PaymentSuccessState){
            return AppDialog.showSuccessEvent(context, AppLocalizations.of(context).translate(state.mess));
          }
      else if(state is PaymentErrorState){
        return AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate(state.mess));
      }
    })
    );
  }


}
