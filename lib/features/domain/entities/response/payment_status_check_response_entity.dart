// To parse this JSON data, do
//
//     final paymentStatusCheckResponse = paymentStatusCheckResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentStatusCheckResponseEntity extends Equatable {
  PaymentStatusCheckResponseEntity(
      {this.responseCode, this.responseError, this.paymentStatus});

  String responseCode;
  String responseError;
  String paymentStatus;

  factory PaymentStatusCheckResponseEntity.fromRawJson(String str) =>
      PaymentStatusCheckResponseEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentStatusCheckResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      PaymentStatusCheckResponseEntity(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "paymentStatus": paymentStatus,
      };

  @override
  List<Object> get props => [responseError, responseCode];
}
