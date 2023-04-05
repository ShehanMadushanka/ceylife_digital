// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/create_user_response_entity.dart';

class CreateUserResponse extends CreateUserResponseEntity {
  CreateUserResponse({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
  }) : super(
            email: email,
            responseError: responseError,
            otpRef: otpRef,
            mobileNo: mobileNo,
            userType: userType,
            responseCode: responseCode);

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;

  factory CreateUserResponse.fromRawJson(String str) =>
      CreateUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      CreateUserResponse(
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
