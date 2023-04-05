// To parse this JSON data, do
//
//     final notificationStatusChangeRequest = notificationStatusChangeRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/notification_status_change_request.dart';

class NotificationStatusChangeRequestEntity
    extends NotificationStatusChangeRequest {
  NotificationStatusChangeRequestEntity(
      {this.notificationReadHistoryIds, this.status, this.mobileUserId})
      : super(
            status: status,
            notificationReadHistoryIds: notificationReadHistoryIds,
            mobileUserId: mobileUserId);

  List<int> notificationReadHistoryIds;
  String status;
  int mobileUserId;
}
