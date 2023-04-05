// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetPolicyRequest extends Equatable {
  final String key;
  final int keyType;
  final int registrationType;

  GetPolicyRequest({this.key, this.keyType, this.registrationType});

  factory GetPolicyRequest.fromRawJson(String str) =>
      GetPolicyRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPolicyRequest.fromJson(Map<String, dynamic> json) =>
      GetPolicyRequest(
        key: json["key"],
        keyType: json["keyType"],
        registrationType: json["registrationType"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "keyType": keyType,
        "registrationType": registrationType,
      };

  @override
  List<Object> get props => [key, keyType];
}
