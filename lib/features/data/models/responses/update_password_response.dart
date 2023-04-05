import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/update_password_response_entity.dart';

class UpdatePasswordResponse extends UpdatePasswordResponseEntity {
  UpdatePasswordResponse({
    this.email,
    this.mobileNo,
    this.nickName,
    this.otpRef,
    this.responseCode,
    this.responseError,
    this.userType,
  }) : super(
            responseError: responseError,
            email: email,
            responseCode: responseCode,
            userType: userType,
            mobileNo: mobileNo,
            otpRef: otpRef,
            nickName: nickName);

  String email;
  String mobileNo;
  String nickName;
  String otpRef;
  String responseCode;
  String responseError;
  int userType;

  factory UpdatePasswordResponse.fromRawJson(String str) =>
      UpdatePasswordResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordResponse(
        email: json["email"],
        mobileNo: json["mobileNo"],
        nickName: json["nickName"],
        otpRef: json["otpRef"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobileNo": mobileNo,
        "nickName": nickName,
        "otpRef": otpRef,
        "response_code": responseCode,
        "response_error": responseError,
        "userType": userType,
      };
}
