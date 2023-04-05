import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class PasswordResetState extends BaseState<PasswordResetState> {}

class InitialPasswordResetState extends PasswordResetState {}

class UserDataSuccessState extends PasswordResetState{
  final ConfigurationData configurationData;
  final ProfileEntity cacheUser;

  UserDataSuccessState({this.configurationData, this.cacheUser});
}

class PasswordMatchingFailedState extends PasswordResetState{
  final String error;

  PasswordMatchingFailedState({this.error});
}

class PasswordResetFailedState extends PasswordResetState{
  final String error;

  PasswordResetFailedState({this.error});
}

class PasswordResetSuccessState extends PasswordResetState{
  final PasswordResetResponseEntity passwordResetResponseEntity;

  PasswordResetSuccessState({this.passwordResetResponseEntity});
}
