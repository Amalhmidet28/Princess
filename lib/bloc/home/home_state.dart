part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeDataFoundState extends HomeState {
  final HomePageData? homePageData;

  HomeDataFoundState(this.homePageData);
}
class SearchResultsState extends HomeState {
  final List<SalonData> filteredSalons;
  SearchResultsState(this.filteredSalons);
}
