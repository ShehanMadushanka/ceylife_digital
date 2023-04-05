import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PasswordResetEvent extends BaseEvent {}

class GetConfigDataEvent extends PasswordResetEvent {}

class ResetPasswordEvent extends PasswordResetEvent{
  final String oldPassword;
  final String newPassword;
  final String repeatPassword;

  ResetPasswordEvent({this.oldPassword, this.newPassword, this.repeatPassword});
}
