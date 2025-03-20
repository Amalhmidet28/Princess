import 'package:equatable/equatable.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object> get props => [];
}

class ToggleRememberMe extends SecurityEvent {}

class ToggleFaceID extends SecurityEvent {}

class ToggleBiometricID extends SecurityEvent {}

class ResetSecuritySettings extends SecurityEvent {}
