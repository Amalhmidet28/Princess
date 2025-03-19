abstract class FavouriteEvent {}

class OnTabClickEvent extends FavouriteEvent {
  final int selectedIndex;

  OnTabClickEvent(this.selectedIndex);
}

class FetchFavouriteDataEvent extends FavouriteEvent {}
class ToggleBookmarkEvent extends FavouriteEvent {
  final int salonId; // Identify which salon to bookmark/unbookmark
  ToggleBookmarkEvent(this.salonId);
}
