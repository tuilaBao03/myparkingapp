import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/payment/payment_event.dart';
import 'package:myparkingapp/bloc/payment/payment_state.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitialState()) {
    on<GetPaymentEvent>(_onPayment);
  }

  Future<void> _onPayment(GetPaymentEvent event, Emitter<PaymentState> emit) async {
    try {
      emit(PaymentLoadingState());

      final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
        url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
        version: '2.0.1',
        tmnCode: 'CVXOW51B',
        txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
        orderInfo: event.orderInfo,
        amount: event.amount,
        returnUrl: 'XXXXXX',  // URL xử lý kết quả
        ipAdress: '192.168.10.10',
        vnpayHashKey: 'WN9I2JRPC6ASCWQ1XS8C94WYEYJFCTR5',
        vnPayHashType: VNPayHashType.HMACSHA512,
        vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
        bankCode: BankCode.VNBANK

        
      );

      emit(PaymentUrlGeneratedState(paymentUrl));  // Gửi URL lên UIN
    } catch (e) {
      emit(PaymentErrorState("Lỗi khi tạo URL thanh toán"));
    }
  }
}
