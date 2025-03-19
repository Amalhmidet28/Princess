import 'package:cutfx/bloc/fav/favourite_event.dart';
import 'package:cutfx/bloc/fav/favourite_state.dart';
import 'package:cutfx/model/fav/favourite_data.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  Set<int> bookmarkedIds = {}; // Store bookmarked IDs

  FavouriteBloc() : super(FavouriteInitialState()) {
    on<OnTabClickEvent>(
      (event, emit) {
        selectedIndex = event.selectedIndex;
        add(FetchFavouriteDataEvent());
      },
    );

    on<FetchFavouriteDataEvent>(
      (event, emit) async {
        emit(FavouriteInitialState());
        FavouriteData favouriteData = await ApiService().fetchFavoriteData();
        emit(FavouriteDataFound(favouriteData, bookmarkedIds: bookmarkedIds));
      },
    );

    on<ToggleBookmarkEvent>((event, emit) {
      if (bookmarkedIds.contains(event.salonId)) {
        bookmarkedIds.remove(event.salonId);
      } else {
        bookmarkedIds.add(event.salonId);
      }

      if (state is FavouriteDataFound) {
        emit(FavouriteDataFound(
          (state as FavouriteDataFound).favouriteData,
          bookmarkedIds: Set.from(bookmarkedIds),
        ));
      }
    });

    add(FetchFavouriteDataEvent());
  }

  int selectedIndex = 0;
}
