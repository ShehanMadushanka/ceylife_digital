
import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/register_lead_generator_response_entity.dart';


class RegisterLeadGeneratorResponse extends RegisterLeadGeneratorResponseEntity {
  RegisterLeadGeneratorResponse({
    this.email,
    this.leadGeneratorId,
    this.mobileNo,
    this.otpRef,
    this.responseCode,
    this.responseError,
  }): super(
      email: email,
      leadGeneratorId: leadGeneratorId,
      mobileNo: mobileNo,
      otpRef: otpRef,
      responseError: responseError,
      responseCode: responseCode);

  String email;
  int leadGeneratorId;
  String mobileNo;
  String otpRef;
  String responseCode;
  String responseError;
  factory RegisterLeadGeneratorResponse.fromRawJson(String str) =>
      RegisterLeadGeneratorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterLeadGeneratorResponse.fromJson(Map<String, dynamic> json) => RegisterLeadGeneratorResponse(
    email: json["email"],
    leadGeneratorId: json["leadGeneratorId"],
    mobileNo: json["mobileNo"],
    otpRef: json["otpRef"],
    responseCode: json["response_code"],
    responseError: json["response_error"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "leadGeneratorId": leadGeneratorId,
    "mobileNo": mobileNo,
    "otpRef": otpRef,
    "response_code": responseCode,
    "response_error": responseError,
  };
}
