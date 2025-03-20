import 'package:cutfx/model/security/security_model.dart';
import 'package:equatable/equatable.dart';


class SecurityState extends Equatable {
  final SecuritySettings settings;

  const SecurityState({required this.settings});

  @override
  List<Object> get props => [settings];
}
