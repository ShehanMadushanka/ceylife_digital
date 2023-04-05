// To parse this JSON data, do
//
//     final userProfileRequest = userProfileRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProfileRequest extends Equatable {
  UserProfileRequest({
    this.mobileUserId,
  });

  int mobileUserId;

  factory UserProfileRequest.fromRawJson(String str) =>
      UserProfileRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileRequest.fromJson(Map<String, dynamic> json) =>
      UserProfileRequest(
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
      };

  @override
  List<Object> get props => [mobileUserId];
}
