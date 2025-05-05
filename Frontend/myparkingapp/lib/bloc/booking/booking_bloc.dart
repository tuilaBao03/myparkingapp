import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/booking/booking_event.dart';
import 'package:myparkingapp/bloc/booking/booking_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/discount_repository.dart';
import 'package:myparkingapp/data/repository/wallet_repository.dart';
import 'package:myparkingapp/data/request/created_invoice_request.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';
import 'package:myparkingapp/demo_data.dart';

import '../../data/response/discount_response.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState()) {
    on<BookingInitialInvoiceEvent>(_loadBookingScreen);
    on<GetMonthOderEvent>(_bookingCreateMonthInvoice);
    on<GetDateOderEvent>(_bookingCreateDateInvoice);
  }

  void _loadBookingScreen(
    BookingInitialInvoiceEvent event,
    Emitter<BookingState> emit,
  ) async {
    DiscountRepository discountRepository = DiscountRepository();
    WalletRepository walletRepository = WalletRepository();
    try {
      emit(BookingLoadingState());
      ApiResult discountAPI = await discountRepository.getListDiscountByLot(event.lot);
      List<DiscountResponse> discounts = discountAPI.result;
      ApiResult walletAPI = await walletRepository.getWalletByUser(event.user);
      List<MonthInfo> months = await MonthInfo.renderMonthList(DateTime.now());
      List<WalletResponse> wallets = walletAPI.result;

      List<VehicleResponse> vehicles = event.user.vehicles;

      emit(
        BookingLoadedState(
          discounts,
          months,

          wallets,
          vehicles,

        ),
      );
    } catch (e) {
      throw Exception("BookingBloc_loadBookingScreen : $e");
    }
  }

  void _bookingCreateDateInvoice(
    GetDateOderEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {


      InvoiceCreatedDailyRequest invoiceCre = InvoiceCreatedDailyRequest(
        description: "Deposit Parking Slot",
        discountCode: event.discount?.discountCode,  // discountCode có thể là null
        parkingSlotID: event.slot.slotID,
        vehicleID: event.vehicle.vehicleId,
        userID: event.user.userID,
        walletID: event.wallet.walletId,
        total: event.slot.pricePerHour * 3,  // Tính tổng tiền
      );
      emit(GotoInvoiceCreateDetailState(invoiceCre,null));
    } catch (e) {
      Exception(e);
    }
  }

  void _bookingCreateMonthInvoice(
    GetMonthOderEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {

      double budget = event.slot.pricePerMonth;
      if (event.discount!.discountType == DiscountType.PERCENTAGE) {
        budget = budget * (1 - event.discount!.discountValue);
      } else {
        budget = budget - event.discount!.discountValue;
      }


      InvoiceCreatedMonthlyRequest request = InvoiceCreatedMonthlyRequest(
        description: "Payment Parking Slot By Month ${event.monthList.monthName}",
        discountCode: event.discount?.discountCode,  // discountCode có thể là null
        parkingSlotID: event.slot.slotID,
        vehicleID: event.vehicle.vehicleId,
        userID: event.user.userID,
        walletID: event.wallet.walletId,
        startedAt: event.monthList.start,
        expiredAt: event.monthList.end,
        total: budget,
      );


      emit(GotoInvoiceCreateDetailState(null,request));
    } catch (e) {
      Exception(e);
    }
  }
}
