import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class OtpEvent extends BaseEvent {}

class GetOtpEvent extends OtpEvent {
  final String key;
  final int keyType;
  final String otpRef;
  final String userOtp;

  GetOtpEvent({this.key, this.keyType, this.otpRef, this.userOtp});

}
class ResendOtpEvent extends OtpEvent {
  final String key;
  final int keyType;

  ResendOtpEvent({this.key, this.keyType});

}

class GetConfigurationData extends OtpEvent{

}

