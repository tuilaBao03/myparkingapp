abstract class SearchEvent {}

class SearchScreenSearchAndChosenPageEvent extends SearchEvent{
  int page;
  String searchText;
  SearchScreenSearchAndChosenPageEvent(this.searchText, this.page);
}