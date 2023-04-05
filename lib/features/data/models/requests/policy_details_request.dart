// To parse this JSON data, do
//
//     final paymentDetailsRequest = paymentDetailsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PolicyDetailsRequest extends Equatable {
  PolicyDetailsRequest({
    this.policyNo,
    this.clientNo,
  });

  String policyNo;
  String clientNo;

  factory PolicyDetailsRequest.fromRawJson(String str) =>
      PolicyDetailsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyDetailsRequest.fromJson(Map<String, dynamic> json) =>
      PolicyDetailsRequest(
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
