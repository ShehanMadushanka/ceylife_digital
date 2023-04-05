// To parse this JSON data, do
//
//     final passwordResetOtpResponse = passwordResetOtpResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/password_reset_otp_response_entity.dart';

class PasswordResetOtpResponse extends PasswordResetOtpResponseEntity {
  PasswordResetOtpResponse({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
    this.nickName,
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            email: email,
            nickName: nickName,
            userType: userType,
            otpRef: otpRef,
            mobileNo: mobileNo);

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;
  String nickName;

  factory PasswordResetOtpResponse.fromRawJson(String str) =>
      PasswordResetOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordResetOtpResponse.fromJson(Map<String, dynamic> json) =>
      PasswordResetOtpResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        otpRef: json["otpRef"],
        userType: json["userType"],
        nickName: json["nickName"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "email": email,
        "mobileNo": mobileNo,
        "otpRef": otpRef,
        "userType": userType,
        "nickName": nickName,
      };
}
