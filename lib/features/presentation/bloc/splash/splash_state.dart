import 'package:ceylife_digital/features/domain/entities/response/key_exchange_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/enums.dart';

abstract class SplashState extends BaseState<SplashState> {}

class InitialSplashState extends SplashState {}

class SplashSuccessState extends SplashState {
  final SplashResponseEntity splashResponseEntity;
  final bool isLanguageExists;
  final Languages languages;

  SplashSuccessState({this.splashResponseEntity, this.isLanguageExists = true, this.languages});
}

class SplashFailedState extends SplashState {
  final String error;

  SplashFailedState({this.error});
}

class ExchangeKeySuccessState extends SplashState {
  final KeyExchangeResponseEntity exchangeResponseEntity;

  ExchangeKeySuccessState({this.exchangeResponseEntity});
}

class ExchangeKeyFailedState extends SplashState {
  final String error;

  ExchangeKeyFailedState({this.error});
}

class PushTokenSuccessState extends SplashState {
  final String token;

  PushTokenSuccessState(this.token);
}

class ForceUpdateState extends SplashState {}
