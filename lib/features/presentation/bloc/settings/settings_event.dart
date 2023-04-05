import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';
import 'package:ceylife_digital/utils/device_info.dart';
import 'package:ceylife_digital/utils/enums.dart';

abstract class SettingsEvent extends BaseEvent {}

class GetCacheUserEvent extends SettingsEvent{}

class BiometricRegistrationEvent extends SettingsEvent{
  bool isBiometricEnabled;

  BiometricRegistrationEvent({this.isBiometricEnabled});
}

class GetLoginEvent extends SettingsEvent {
  final String username;
  final String password;
  final SignInType signInType;
  final DeviceInfo deviceInfo;

  GetLoginEvent({this.username, this.password, this.deviceInfo, this.signInType});
}