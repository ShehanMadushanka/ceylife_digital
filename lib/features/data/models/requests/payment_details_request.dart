// To parse this JSON data, do
//
//     final paymentDetailsRequest = paymentDetailsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentDetailsRequest extends Equatable {
  PaymentDetailsRequest({
    this.policyNo,
    this.clientNo,
    this.pageNo
  });

  String policyNo;
  String clientNo;
  int pageNo;

  factory PaymentDetailsRequest.fromRawJson(String str) =>
      PaymentDetailsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentDetailsRequest.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsRequest(
        policyNo: json["policyNo"],
        clientNo: json["clientNo"],
      );

  Map<String, dynamic> toJson() => {
        "policyNo": policyNo,
        "clientNo": clientNo,
      };

  @override
  List<Object> get props => [policyNo, clientNo];
}
