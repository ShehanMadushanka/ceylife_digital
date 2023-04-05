// To parse this JSON data, do
//
//     final passwordResetOtpRequest = passwordResetOtpRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordResetOtpRequest extends Equatable {
  PasswordResetOtpRequest({
    this.mobileUserId,
  });

  int mobileUserId;

  factory PasswordResetOtpRequest.fromRawJson(String str) =>
      PasswordResetOtpRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordResetOtpRequest.fromJson(Map<String, dynamic> json) =>
      PasswordResetOtpRequest(
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
      };

  @override
  List<Object> get props => [mobileUserId];
}
