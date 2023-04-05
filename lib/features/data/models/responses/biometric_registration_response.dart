// To parse this JSON data, do
//
//     final biometricRegistrationResponse = biometricRegistrationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/biometric_registration_response_entity.dart';

class BiometricRegistrationResponse
    extends BiometricRegistrationResponseEntity {
  BiometricRegistrationResponse({
    this.responseCode,
    this.responseError,
  }) : super(responseError: responseError, responseCode: responseCode);

  String responseCode;
  String responseError;

  factory BiometricRegistrationResponse.fromRawJson(String str) =>
      BiometricRegistrationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      BiometricRegistrationResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
      };
}
