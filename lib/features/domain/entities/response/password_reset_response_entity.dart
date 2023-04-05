// To parse this JSON data, do
//
//     final passwordResetResponse = passwordResetResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class PasswordResetResponseEntity extends Equatable {
  PasswordResetResponseEntity({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
    this.nickName,
  });

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;
  String nickName;

  @override
  List<Object> get props => [responseError, responseCode, email];
}
