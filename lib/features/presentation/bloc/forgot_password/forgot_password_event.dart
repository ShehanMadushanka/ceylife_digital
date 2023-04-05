import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class ForgotPasswordEvent extends BaseEvent {}

class UpdatePassword extends ForgotPasswordEvent {
  final String password;
  final String repeatPassword;

  UpdatePassword({
    this.password,
    this.repeatPassword,
  });
}

class GetConfigData extends ForgotPasswordEvent {}
