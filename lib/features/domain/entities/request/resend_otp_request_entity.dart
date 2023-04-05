import 'package:ceylife_digital/features/data/models/requests/resend_otp_request.dart';

class ResendOtpRequestEntity extends ResendOtpRequest {
  ResendOtpRequestEntity({
    this.key,
    this.keyType,

  }) : super(
          key: key,
          keyType: keyType,
        );

  final String key;
  final int keyType;
}
