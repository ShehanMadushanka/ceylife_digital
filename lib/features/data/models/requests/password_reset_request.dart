// To parse this JSON data, do
//
//     final passwordResetRequest = passwordResetRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordResetRequest extends Equatable {
  PasswordResetRequest({
    this.mobileUserId,
    this.oldPassword,
    this.password,
  });

  int mobileUserId;
  String oldPassword;
  String password;

  factory PasswordResetRequest.fromRawJson(String str) =>
      PasswordResetRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      PasswordResetRequest(
        mobileUserId: json["mobileUserId"],
        oldPassword: json["oldPassword"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
        "oldPassword": oldPassword,
        "password": password,
      };

  @override
  List<Object> get props => [mobileUserId, oldPassword, password];
}
