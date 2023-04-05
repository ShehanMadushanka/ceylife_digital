// To parse this JSON data, do
//
//     final paymentStatusCheckRequest = paymentStatusCheckRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentStatusCheckRequest extends Equatable {
  PaymentStatusCheckRequest({
    this.refCode,
  });

  String refCode;

  factory PaymentStatusCheckRequest.fromRawJson(String str) =>
      PaymentStatusCheckRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentStatusCheckRequest.fromJson(Map<String, dynamic> json) =>
      PaymentStatusCheckRequest(
        refCode: json["refCode"],
      );

  Map<String, dynamic> toJson() => {
        "refCode": refCode,
      };

  @override
  List<Object> get props => [refCode];
}
