
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';


abstract class SearchState{}

class SearchScreenInitial extends SearchState{


}

class SearchScreenLoading extends SearchState{

}

class SearchScreenLoaded extends SearchState{
  final LotOnPage lotOnPage;
  final String searchText;
  final UserResponse user;
  SearchScreenLoaded(this.lotOnPage, this.searchText, this.user);
}

class SearchScreenError extends SearchState{
  final String mess;
  SearchScreenError(this.mess);
}