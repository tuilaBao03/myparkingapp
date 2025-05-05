import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/discount/discount_event.dart';
import 'package:myparkingappadmin/bloc/discount/discount_state.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/discountRepository.dart';

class  DiscountBloc extends Bloc< DiscountEvent, DiscountState>{
   DiscountBloc():super(DiscountInitial()){
    on<DiscountLoadingScreenEvent>(giveDiscountByParkingLot);
    on<CreateDiscountEvent>(createDiscount);  
    on<UpdateDiscountEvent>(updateDiscount);
    on<DeleteDiscountEvent>(deleteDiscount);
   }
   void giveDiscountByParkingLot(DiscountLoadingScreenEvent event, Emitter<DiscountState> emit) async {
     try {
      emit(DiscountLoadingState());
    
      DiscountRepository discountRepository = DiscountRepository();
      ApiResult result = await discountRepository.giveDiscountByParkingLot(event.parkingLotId);
      if(result.code == 200){
        emit(DiscountLoadedState(result.result));
      } else {
        emit(DiscountErrorState(result.message));
      } // Replace with actual data
     } catch (e) {
       emit(DiscountErrorState(e.toString()));
     }
   }
   void createDiscount(CreateDiscountEvent event, Emitter<DiscountState> emit) async {
     try {
      emit(DiscountLoadingState());
    
      DiscountRepository discountRepository = DiscountRepository();
      ApiResult result = await discountRepository.createDiscount(event.request);
      if(result.code == 200){
        emit(DiscountSuccessState(result.message));
      } else {
        emit(DiscountErrorState(result.message));
      } // Replace with actual data
     } catch (e) {
       emit(DiscountErrorState(e.toString()));
     }
   }
   void updateDiscount(UpdateDiscountEvent event, Emitter<DiscountState> emit) async {
     try {
      emit(DiscountLoadingState());
    
      DiscountRepository discountRepository = DiscountRepository();
      ApiResult result = await discountRepository.updateDiscount(event.request, event.id);
      if(result.code == 200){
        emit(DiscountSuccessState(result.message));
      } else {
        emit(DiscountErrorState(result.message));
      } // Replace with actual data
     } catch (e) {
       emit(DiscountErrorState(e.toString()));
     }
   }
   void deleteDiscount(DeleteDiscountEvent event, Emitter<DiscountState> emit) async {
     try {
      emit(DiscountLoadingState());
    
      DiscountRepository discountRepository = DiscountRepository();
      ApiResult result = await discountRepository.deleteDiscount(event.discountId);
      if(result.code == 200){
        emit(DiscountSuccessState(result.message));
      } else {
        emit(DiscountErrorState(result.message));
      } // Replace with actual data
     } catch (e) {
       emit(DiscountErrorState(e.toString()));
     }
   }

}