// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetOtpRequest extends Equatable {
  final String key;
  final int keyType;
  final String otpRef;
  final String userOtp;

  GetOtpRequest({
    this.key,
    this.keyType,
    this.otpRef,
    this.userOtp,
  });

  factory GetOtpRequest.fromRawJson(String str) =>
      GetOtpRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOtpRequest.fromJson(Map<String, dynamic> json) => GetOtpRequest(
        key: json["key"],
        keyType: json["keyType"],
        otpRef: json["otpRef"],
        userOtp: json["userOTP"],
      );

  Map<String, dynamic> toJson() =>
      {"key": key, "keyType": keyType, "otpRef": otpRef, "userOTP": userOtp};

  @override
  List<Object> get props => [key, keyType, otpRef, userOtp];
}
