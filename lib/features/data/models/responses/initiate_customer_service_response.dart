// To parse this JSON data, do
//
//     final initiateCustomerServiceResponse = initiateCustomerServiceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';

class InitiateCustomerServiceResponse
    extends InitiateCustomerServiceResponseEntity {
  InitiateCustomerServiceResponse({
    this.responseCode,
    this.responseError,
  }) : super(responseError: responseError, responseCode: responseCode);

  String responseCode;
  String responseError;

  factory InitiateCustomerServiceResponse.fromRawJson(String str) =>
      InitiateCustomerServiceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InitiateCustomerServiceResponse.fromJson(Map<String, dynamic> json) =>
      InitiateCustomerServiceResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
      };
}
