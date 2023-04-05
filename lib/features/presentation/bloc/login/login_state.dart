import 'package:ceylife_digital/features/data/models/common/user.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/user_profile_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class LoginState extends BaseState<LoginState> {}

class InitialLoginState extends LoginState {
}

class CacheUserSuccessState extends LoginState{
  final ProfileEntity user;

  CacheUserSuccessState({this.user});
}

class LoginLoadedState extends LoginState {
  final LoginResponseEntity loginResponseEntity;

  LoginLoadedState({this.loginResponseEntity});
}

class LoginFailedState extends LoginState {
  final String error;

  LoginFailedState({this.error});
}

class ValidationFailedState extends LoginState {
  final String error;

  ValidationFailedState({this.error});
}
