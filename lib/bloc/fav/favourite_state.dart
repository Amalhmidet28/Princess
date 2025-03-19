import 'package:cutfx/model/fav/favourite_data.dart';

abstract class FavouriteState {
  var services;
}

class FavouriteInitialState extends FavouriteState {}

class ChangeTabState extends FavouriteState {
  final int selectedIndex;

  ChangeTabState(this.selectedIndex);
}

class FavouriteDataFound extends FavouriteState {
  final FavouriteData favouriteData;

 


  final Set<int> bookmarkedIds; // Track bookmarked items by ID

  FavouriteDataFound(this.favouriteData, {this.bookmarkedIds = const {}});
}
