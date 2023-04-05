import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class SplashEvent extends BaseEvent {}

class SplashRequestEvent extends SplashEvent {}

class ExchangeKeyEvent extends SplashEvent {}

class GetPushToken extends SplashEvent {}
