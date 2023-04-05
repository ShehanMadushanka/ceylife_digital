
import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/verify_new_lead_generator_response_entity.dart';
class VerifyNewLeadGeneratoResponse extends VerifyNewLeadGeneratoResponseEntity{
  VerifyNewLeadGeneratoResponse({
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
  factory VerifyNewLeadGeneratoResponse.fromRawJson(String str) =>
      VerifyNewLeadGeneratoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyNewLeadGeneratoResponse.fromJson(Map<String, dynamic> json) => VerifyNewLeadGeneratoResponse(
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
