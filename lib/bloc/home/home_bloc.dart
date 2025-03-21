import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeDataEvent>(_onFetchHomeDataEvent);
    on<FetchNearBySalonEvent>(_onFetchNearBySalonEvent);
    add(FetchHomeDataEvent());
  }

  SalonUser? salonUser;
  List<SalonData> salons = [];
  HomePageData? homePageData;

  Future<void> _onFetchHomeDataEvent(
      FetchHomeDataEvent event, Emitter<HomeState> emit) async {
    SharePref sharePref = await SharePref().init();
    salonUser = sharePref.getSalonUser();
    homePageData = await ApiService().fetchHomePageData();

    await fetchLocation(); // Attendre que la localisation soit récupérée avant d'émettre l'état

    emit(HomeDataFoundState(homePageData));
  }

  Future<void> _onFetchNearBySalonEvent(
      FetchNearBySalonEvent event, Emitter<HomeState> emit) async {
    if (homePageData != null) {
      homePageData!.nearbySalons = salons;
    }
    emit(HomeDataFoundState(homePageData));
  }

  Future<void> fetchLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      AppRes.longitude = position.longitude;
      AppRes.latitude = position.latitude;

      SalonByCoordinates salonByCoordinates =
          await ApiService().fetchSalonByCoordinates(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      );

      salons = salonByCoordinates.data ?? [];

      // Mettre à jour homePageData avec les salons trouvés
      if (homePageData != null) {
        homePageData!.nearbySalons = salons;
      }

      add(FetchNearBySalonEvent()); // Émettre un nouvel événement pour rafraîchir l'UI
    } catch (e) {
      print("Erreur lors de la récupération de la localisation: $e");
    }
  }
}
