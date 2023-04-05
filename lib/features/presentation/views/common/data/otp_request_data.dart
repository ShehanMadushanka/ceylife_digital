import 'package:flutter/cupertino.dart';

class OTPRequestData {
  final String key;
  final int keyType;
  final String otpReference;
  final bool shouldHideProgress;
  final String maskedEmail;
  final String maskedMobile;

  final String appBarTitle;

  OTPRequestData(
      {@required this.key,
      @required this.keyType,
      @required this.otpReference,
      this.maskedEmail,
      this.shouldHideProgress = false,
      @required this.maskedMobile,
      @required this.appBarTitle});
}
