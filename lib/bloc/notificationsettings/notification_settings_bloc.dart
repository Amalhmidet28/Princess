import 'package:cutfx/model/notifsettings/notificationsettings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Events
abstract class NotificationSettingsEvent {}

class ToggleSetting extends NotificationSettingsEvent {
  final String settingKey;
  final bool value;

  ToggleSetting({required this.settingKey, required this.value});
}

// State
class NotificationSettingsState {
  final NotificationSettings settings;

  NotificationSettingsState({required this.settings});
}

// Bloc
class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc()
      : super(NotificationSettingsState(
          settings: NotificationSettings(
            generalNotification: true,
            sound: true,
            vibrate: false,
            specialOffers: true,
            promoDiscount: false,
            payments: true,
            appUpdates: true,
          ),
        )) {
    on<ToggleSetting>((event, emit) {
      final updatedSettings = state.settings.copyWith(
        generalNotification: event.settingKey == 'generalNotification' ? event.value : state.settings.generalNotification,
        sound: event.settingKey == 'sound' ? event.value : state.settings.sound,
        vibrate: event.settingKey == 'vibrate' ? event.value : state.settings.vibrate,
        specialOffers: event.settingKey == 'specialOffers' ? event.value : state.settings.specialOffers,
        promoDiscount: event.settingKey == 'promoDiscount' ? event.value : state.settings.promoDiscount,
        payments: event.settingKey == 'payments' ? event.value : state.settings.payments,
        appUpdates: event.settingKey == 'appUpdates' ? event.value : state.settings.appUpdates,
      );

      emit(NotificationSettingsState(settings: updatedSettings));
    });
  }
}
