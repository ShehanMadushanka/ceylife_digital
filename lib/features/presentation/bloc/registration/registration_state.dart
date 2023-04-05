import 'package:ceylife_digital/features/data/models/common/configuration_data.dart';
import 'package:ceylife_digital/features/domain/entities/response/create_user_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class RegistrationState extends BaseState<RegistrationState> {}

class InitialRegistrationState extends RegistrationState {
}

class CreateUserSuccessState extends RegistrationState{
  final CreateUserResponseEntity createUserResponseEntity;

  CreateUserSuccessState({this.createUserResponseEntity});
}

class CreateUserFailedState extends RegistrationState{
  final String error;

  CreateUserFailedState({this.error});
}

class PasswordMatchingFailedState extends RegistrationState{
  final String error;

  PasswordMatchingFailedState({this.error});
}

class ExistingUserFailedState extends RegistrationState{
  final String error;

  ExistingUserFailedState({this.error});
}

class ConfigDataSuccessState extends RegistrationState{
  final ConfigurationData configurationData;

  ConfigDataSuccessState({this.configurationData});
}
