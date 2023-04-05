import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class HomeEvent extends BaseEvent {}

class GetProfileDataEvent extends HomeEvent {}

class GetPoliciesEvent extends HomeEvent {}

class PasswordResetOtpRequestEvent extends HomeEvent{}
