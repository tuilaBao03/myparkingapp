import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/search/search_event.dart';
import 'package:myparkingapp/bloc/search/search_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/lots_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
// import 'package:myparkingapp/components/api_result.dart';
// import 'package:myparkingapp/data/repository/lots_repository.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  SearchBloc(): super(SearchScreenInitial()){
    on<SearchScreenSearchAndChosenPageEvent>(_searchScreenSearchAndChosenPage);
  }
  void _searchScreenSearchAndChosenPage(SearchScreenSearchAndChosenPageEvent event, Emitter<SearchState> emit )async{
    LotRepository lotRepository = LotRepository();
    UserRepository userRepository = UserRepository();
    try{

      emit(SearchScreenLoading());
      ApiResult userApi =  await userRepository.getMe();
      ApiResult apiResult = await lotRepository.getParkingLotBySearchAndPage(event.searchText, event.page, 10);
      int code = apiResult.code;
      String mess = apiResult.message;
      if(code == 200){
        LotOnPage lotOnPage = apiResult.result;
        emit(SearchScreenLoaded(lotOnPage, event.searchText,userApi.result));
      }
      else{
        emit(SearchScreenError(mess));
      }
    }
    catch(e){
      throw Exception("_LoadSearchScreen : $e");
    }
  }
}