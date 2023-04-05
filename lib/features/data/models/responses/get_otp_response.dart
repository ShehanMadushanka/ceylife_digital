// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';

class GetOtpResponse extends OtpResponseEntity {
  int userType;
  String nic;
  String nickName;
  String otpRef;
  String userOtp;
  String responseCode;
  String responseError;

  GetOtpResponse({
    this.userType,
    this.nic,
    this.nickName,
    this.otpRef,
    this.userOtp,
    this.responseCode,
    this.responseError,
  }) : super(
            userType: userType,
            responseError: responseError,
            responseCode: responseCode,
            nic: nic,
            nickName: nickName,
            otpRef: otpRef,
            userOtp: userOtp);

  factory GetOtpResponse.fromRawJson(String str) =>
      GetOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOtpResponse.fromJson(Map<String, dynamic> json) => GetOtpResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        nic: json["nic"],
        userType: json["userType"],
        nickName: json["nickName"],
        otpRef: json["otpRef"],
        userOtp: json["userOTP"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "nic": nic,
        "userType": userType,
        "nickName": nickName,
        "otpRef": otpRef,
        "userOTP": userOtp
      };
}
