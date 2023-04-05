// To parse this JSON data, do
//
//     final getNotificationRequest = getNotificationRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetNotificationRequest extends Equatable {
  GetNotificationRequest({
    this.mobileUserId,
  });

  int mobileUserId;

  factory GetNotificationRequest.fromRawJson(String str) =>
      GetNotificationRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetNotificationRequest.fromJson(Map<String, dynamic> json) =>
      GetNotificationRequest(
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "mobileUserId": mobileUserId,
      };

  @override
  List<Object> get props => [mobileUserId];
}
