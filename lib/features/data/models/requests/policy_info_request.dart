// To parse this JSON data, do
//
//     final policyInfoRequest = policyInfoRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PolicyInfoRequest extends Equatable {
  PolicyInfoRequest({
    this.policyNo,
  });

  String policyNo;

  factory PolicyInfoRequest.fromRawJson(String str) =>
      PolicyInfoRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyInfoRequest.fromJson(Map<String, dynamic> json) =>
      PolicyInfoRequest(
        policyNo: json["policyNo"],
      );

  Map<String, dynamic> toJson() => {
        "policyNo": policyNo,
      };

  @override
  List<Object> get props => [policyNo];
}
