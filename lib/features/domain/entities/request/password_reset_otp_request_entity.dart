import 'package:ceylife_digital/features/data/models/requests/password_reset_otp_request.dart';

class PasswordResetOtpRequestEntity extends PasswordResetOtpRequest {
  PasswordResetOtpRequestEntity({
    this.mobileUserId,
  });

  int mobileUserId;
}
