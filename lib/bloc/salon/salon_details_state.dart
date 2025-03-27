part of 'salon_details_bloc.dart';

abstract class SalonDetailsState {}

class SalonDetailsInitial extends SalonDetailsState {}

class SalonDataFetched extends SalonDetailsState {
  final Salon salon;

  SalonDataFetched(this.salon);
}
class SalonDataError extends SalonDetailsState {
  final String errorMessage;
  SalonDataError({required this.errorMessage});
}

class SalonDetailsLoading extends SalonDetailsState {}