import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/resend_otp_response_entity.dart';

class ResendOtpResponse extends ResendOtpResponseEntity {
  ResendOtpResponse(
      {this.responseCode,
      this.responseError,
      this.email,
      this.mobileNo,
      this.otpRef,
      this.userType,
      this.nickName})
      : super(
            responseCode: responseCode,
            responseError: responseError,
            email: email,
            mobileNo: mobileNo,
            otpRef: otpRef,
            userType: userType,
            nickName: nickName);

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;
  String nickName;

  factory ResendOtpResponse.fromRawJson(String str) =>
      ResendOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponse(
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
        "nickName": nickName
      };
}
