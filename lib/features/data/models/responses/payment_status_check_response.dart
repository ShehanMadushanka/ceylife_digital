// To parse this JSON data, do
//
//     final paymentStatusCheckResponse = paymentStatusCheckResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/payment_status_check_response_entity.dart';

class PaymentStatusCheckResponse extends PaymentStatusCheckResponseEntity {
  PaymentStatusCheckResponse({
    this.responseCode,
    this.responseError,
    this.paymentStatus
  }) : super(responseCode: responseCode, responseError: responseError);

  String responseCode;
  String responseError;
  String paymentStatus;

  factory PaymentStatusCheckResponse.fromRawJson(String str) =>
      PaymentStatusCheckResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentStatusCheckResponse.fromJson(Map<String, dynamic> json) =>
      PaymentStatusCheckResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "paymentStatus": paymentStatus,
      };
}
