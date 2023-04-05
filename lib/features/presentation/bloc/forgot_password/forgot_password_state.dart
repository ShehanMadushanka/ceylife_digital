import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/update_password_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class ForgotPasswordState extends BaseState<ForgotPasswordState> {}

class InitialForgotPasswordState extends ForgotPasswordState {}

class UpdatePasswordSuccessState extends ForgotPasswordState {
  final UpdatePasswordResponseEntity updatePasswordResponseEntity;

  UpdatePasswordSuccessState({this.updatePasswordResponseEntity});
}

class UpdatePasswordFailedState extends ForgotPasswordState {
  final String error;

  UpdatePasswordFailedState({this.error});
}

class PasswordMatchingFailedState extends ForgotPasswordState {
  final String error;

  PasswordMatchingFailedState({this.error});
}

class ConfigDataSuccessState extends ForgotPasswordState {
  final ConfigurationData configurationData;

  ConfigDataSuccessState({this.configurationData});
}
