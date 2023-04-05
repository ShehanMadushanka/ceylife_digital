// To parse this JSON data, do
//
//     final notificationStatusChangeRequest = notificationStatusChangeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationStatusChangeRequest extends Equatable {
  NotificationStatusChangeRequest({
    this.notificationReadHistoryIds,
    this.status,
    this.mobileUserId,
  });

  List<int> notificationReadHistoryIds;
  String status;
  int mobileUserId;

  factory NotificationStatusChangeRequest.fromRawJson(String str) =>
      NotificationStatusChangeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationStatusChangeRequest.fromJson(Map<String, dynamic> json) =>
      NotificationStatusChangeRequest(
        notificationReadHistoryIds:
            List<int>.from(json["notificationReadHistoryIds"].map((x) => x)),
        status: json["status"],
        mobileUserId: json["mobileUserId"],
      );

  Map<String, dynamic> toJson() => {
        "notificationReadHistoryIds":
            List<dynamic>.from(notificationReadHistoryIds.map((x) => x)),
        "status": status,
        "mobileUserId": mobileUserId,
      };

  @override
  List<Object> get props => [status, notificationReadHistoryIds];
}
