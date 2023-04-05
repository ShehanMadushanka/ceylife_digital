// To parse this JSON data, do
//
//     final passwordResetResponse = passwordResetResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/password_reset_response_entity.dart';

class PasswordResetResponse extends PasswordResetResponseEntity {
  PasswordResetResponse({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
    this.nickName,
  }) : super(
            responseError: responseError,
            mobileNo: mobileNo,
            otpRef: otpRef,
            userType: userType,
            nickName: nickName,
            email: email,
            responseCode: responseCode);

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;
  String nickName;

  factory PasswordResetResponse.fromRawJson(String str) =>
      PasswordResetResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) =>
      PasswordResetResponse(
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
