import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';
import 'package:ceylife_digital/utils/device_info.dart';

abstract class RegistrationEvent extends BaseEvent {}

class CreateUserEvent extends RegistrationEvent {
  final String email;
  final String userId;
  final String nic;
  final String password;
  final String repeatPassword;
  final String nickname;
  final isWebUser;
  final DeviceInfo deviceInfo;

  CreateUserEvent(
      {this.email,
      this.userId,
      this.nic,
      this.password,
      this.repeatPassword,
      this.nickname,
      this.isWebUser,
      this.deviceInfo});
}

class GetConfigData extends RegistrationEvent {}
