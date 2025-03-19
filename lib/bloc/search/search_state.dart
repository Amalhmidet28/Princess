abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchChangeTabState extends SearchState {
  final int selectedIndex;

  SearchChangeTabState(this.selectedIndex);
}
class SearchResultsState extends SearchState {
  final List<dynamic> results; // Peut contenir des salons et des services
  SearchResultsState(this.results);
}
