part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchHomeDataEvent extends HomeEvent {}

class FetchNearBySalonEvent extends HomeEvent {}

class SearchSalonEvent extends HomeEvent {
  final String query;
  SearchSalonEvent(this.query);
}
