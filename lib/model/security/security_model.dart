class SecuritySettings {
  final bool rememberMe;
  final bool faceID;
  final bool biometricID;

  const SecuritySettings({
    required this.rememberMe,
    required this.faceID,
    required this.biometricID,
  });

  SecuritySettings copyWith({
    bool? rememberMe,
    bool? faceID,
    bool? biometricID,
  }) {
    return SecuritySettings(
      rememberMe: rememberMe ?? this.rememberMe,
      faceID: faceID ?? this.faceID,
      biometricID: biometricID ?? this.biometricID,
    );
  }
}
