abstract class SearchEvent {}

class SearchOnTabClickEvent extends SearchEvent {
  final int selectedIndex;

  SearchOnTabClickEvent(this.selectedIndex);
}
class SearchSalonOrServiceEvent extends SearchEvent {
  final String query;
  SearchSalonOrServiceEvent(this.query);
}
