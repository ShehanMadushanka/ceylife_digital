// To parse this JSON data, do
//
//     final healthTipsRequest = healthTipsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class HealthTipsRequest extends Equatable{
  HealthTipsRequest({
    this.mobileUserId,
  });

  int mobileUserId;

  factory HealthTipsRequest.fromRawJson(String str) => HealthTipsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HealthTipsRequest.fromJson(Map<String, dynamic> json) => HealthTipsRequest(
    mobileUserId: json["mobileUserId"],
  );

  Map<String, dynamic> toJson() => {
    "mobileUserId": mobileUserId,
  };

  @override
  List<Object> get props => [mobileUserId];
}
