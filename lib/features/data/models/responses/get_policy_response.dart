// To parse this JSON data, do
//
//     final getPolicyResponse = getPolicyResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/policy_response_entity.dart';

class GetPolicyResponse extends PolicyResponseEntity {
  GetPolicyResponse({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            mobileNo: mobileNo,
            email: email,
            otpRef: otpRef,
            userType: userType);

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;

  factory GetPolicyResponse.fromRawJson(String str) =>
      GetPolicyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPolicyResponse.fromJson(Map<String, dynamic> json) =>
      GetPolicyResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        otpRef: json["otpRef"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "email": email,
        "mobileNo": mobileNo,
        "otpRef": otpRef,
        "userType": userType,
      };
}
