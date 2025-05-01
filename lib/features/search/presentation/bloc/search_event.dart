class SearchEvent {}

class OnSearchEvent extends SearchEvent{
  String searchText;
  OnSearchEvent({required this.searchText});
}

class OnTextEmptyEvent extends SearchEvent{}