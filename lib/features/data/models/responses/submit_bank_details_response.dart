import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/submit_bank_details_response_entity.dart';

class SubmitBankDetailsResponse extends SubmitBankDetailsResponseEntity {
  SubmitBankDetailsResponse({
    this.email,
    this.mobileNo,
    this.otpRef,
    this.responseCode,
    this.responseError,
  }) : super(
          responseError: responseError,
          email: email,
          responseCode: responseCode,
          mobileNo: mobileNo,
          otpRef: otpRef,
        );

  String email;
  String mobileNo;
  String otpRef;
  String responseCode;
  String responseError;

  factory SubmitBankDetailsResponse.fromRawJson(String str) =>
      SubmitBankDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitBankDetailsResponse.fromJson(Map<String, dynamic> json) =>
      SubmitBankDetailsResponse(
        email: json["email"],
        mobileNo: json["mobileNo"],
        otpRef: json["otpRef"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobileNo": mobileNo,
        "otpRef": otpRef,
        "response_code": responseCode,
        "response_error": responseError,
      };
}
