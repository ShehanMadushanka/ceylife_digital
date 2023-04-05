import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class SettingsState extends BaseState<SettingsState> {}

class InitialSettingsState extends SettingsState {}

class CacheUserSuccessState extends SettingsState {
  final ProfileEntity profileEntity;

  CacheUserSuccessState({this.profileEntity});
}

class BiometricEnableSuccessState extends SettingsState {
  final bool shouldEnabled;

  BiometricEnableSuccessState({this.shouldEnabled});
}

class BiometricEnableFailedState extends SettingsState{
  final String error;

  BiometricEnableFailedState({this.error});
}

class AuthSuccessState extends SettingsState{}
