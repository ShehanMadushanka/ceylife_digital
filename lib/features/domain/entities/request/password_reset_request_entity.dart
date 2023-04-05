// To parse this JSON data, do
//
//     final passwordResetRequest = passwordResetRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/password_reset_request.dart';

class PasswordResetRequestEntity extends PasswordResetRequest {
  PasswordResetRequestEntity({
    this.mobileUserId,
    this.oldPassword,
    this.password,
  }) : super(
            mobileUserId: mobileUserId,
            password: password,
            oldPassword: oldPassword);

  int mobileUserId;
  String oldPassword;
  String password;
}
