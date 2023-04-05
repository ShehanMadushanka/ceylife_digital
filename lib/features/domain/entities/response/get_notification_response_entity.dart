// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);

import 'package:ceylife_digital/utils/enums.dart';
import 'package:equatable/equatable.dart';

class GetNotificationResponseEntity extends Equatable {
  GetNotificationResponseEntity({
    this.notifications,
    this.responseCode,
    this.responseError,
  });

  List<NotificationEntity> notifications;
  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode, notifications];
}

class NotificationEntity extends Equatable {
  final NotificationType type;
  final String title;
  final DateTime dateTime;
  final String description;
  final bool status;
  bool isSelected = false;
  final int notificationReadId;

  NotificationEntity(
      {this.type,
      this.title,
      this.dateTime,
      this.description,
      this.status,
      this.notificationReadId});

  @override
  List<Object> get props => [title, dateTime, description, status];
}
