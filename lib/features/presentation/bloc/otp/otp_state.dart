import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/resend_otp_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';

abstract class OtpState extends BaseState<OtpState> {}

class InitialOtpState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpLoadedState extends OtpState {
  final OtpResponseEntity otpResponseEntity;


  OtpLoadedState({this.otpResponseEntity});
}

class OtpFailedState extends OtpState {
  final String error;

  OtpFailedState({this.error});
}

class ValidationFailedState extends OtpState {
  final String error;

  ValidationFailedState({this.error});
}
class ResendOtpSuccessState extends OtpState {
  final ResendOtpResponseEntity resendOtpResponseEntity;

  ResendOtpSuccessState({this.resendOtpResponseEntity});
}

class ConfigDataSuccessState extends OtpState{
  final ConfigurationData configurationData;

  ConfigDataSuccessState({this.configurationData});
}
