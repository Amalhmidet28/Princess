import 'package:cutfx/model/security/security_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'security_event.dart';
import 'security_state.dart';


class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc()
      : super(SecurityState(
          settings: const SecuritySettings(
            rememberMe: true,
            faceID: false,
            biometricID: true,
          ),
        )) {
    on<ToggleRememberMe>((event, emit) {
      emit(SecurityState(
        settings: state.settings.copyWith(rememberMe: !state.settings.rememberMe),
      ));
    });

    on<ToggleFaceID>((event, emit) {
      emit(SecurityState(
        settings: state.settings.copyWith(faceID: !state.settings.faceID),
      ));
    });

    on<ToggleBiometricID>((event, emit) {
      emit(SecurityState(
        settings: state.settings.copyWith(biometricID: !state.settings.biometricID),
      ));
    });

    on<ResetSecuritySettings>((event, emit) {
      emit(SecurityState(
        settings: const SecuritySettings(
          rememberMe: false,
          faceID: false,
          biometricID: false,
        ),
      ));
    });
  }
}
