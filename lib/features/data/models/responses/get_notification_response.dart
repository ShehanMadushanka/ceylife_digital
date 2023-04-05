// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:intl/intl.dart';

class GetNotificationResponse extends GetNotificationResponseEntity {
  GetNotificationResponse({
    this.notificationsObj,
    this.responseCode,
    this.responseError,
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            notifications: notificationsObj);

  List<Notification> notificationsObj;
  String responseCode;
  String responseError;

  factory GetNotificationResponse.fromRawJson(String str) =>
      GetNotificationResponse.fromJson(json.decode(str));

  factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationResponse(
        notificationsObj: json["notifications"] != null
            ? List<Notification>.from(
                json["notifications"].map((x) => Notification.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );
}

class Notification extends NotificationEntity {
  Notification({
    this.body,
    this.createdDateTime,
    this.notificationId,
    this.notificationReadId,
    this.notificationType,
    this.status,
    this.title,
  }) : super(
            title: title,
            description: body,
            status: status,
            dateTime: createdDateTime,
            type: notificationType == AppConstants.NOTIFICATION_TYPE_NEWS
                ? NotificationType.NEWS
                : NotificationType.PROMO,
            notificationReadId: notificationReadId);

  String body;
  DateTime createdDateTime;
  int notificationId;
  int notificationReadId;
  String notificationType;
  bool status;
  String title;

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        body: json["body"],
        createdDateTime:
            DateFormat(YYYY_MM_DD_HH_mm_a).parse(json["createdDateTime"]),
        notificationId: json["notificationId"],
        notificationReadId: json["notificationReadId"],
        notificationType: json["notificationType"],
        status: json["status"] == AppConstants.STATUS_NOTIFICATION_READ,
        title: json["title"],
      );
}
