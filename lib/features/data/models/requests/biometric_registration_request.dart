// To parse this JSON data, do
//
//     final biometricRegistrationRequest = biometricRegistrationRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BiometricRegistrationRequest extends Equatable{
  BiometricRegistrationRequest({
    this.mobileUserId,
    this.bioAuthEnable,
  });

  int mobileUserId;
  int bioAuthEnable;

  factory BiometricRegistrationRequest.fromRawJson(String str) => BiometricRegistrationRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricRegistrationRequest.fromJson(Map<String, dynamic> json) => BiometricRegistrationRequest(
    mobileUserId: json["mobileUserId"],
    bioAuthEnable: json["bioAuthEnable"],
  );

  Map<String, dynamic> toJson() => {
    "mobileUserId": mobileUserId,
    "bioAuthEnable": bioAuthEnable,
  };

  @override
  List<Object> get props => [mobileUserId, bioAuthEnable];
}
