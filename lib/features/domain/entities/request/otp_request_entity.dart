// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/get_otp_request.dart';

class OtpRequestEntity extends GetOtpRequest {
  OtpRequestEntity({
    this.key,
    this.keyType,
    this.otpRef,
    this.userOtp,
  }) : super(key: key, keyType: keyType, otpRef: otpRef, userOtp: userOtp);

  final String key;
  final int keyType;
  final String otpRef;
  final String userOtp;
}
