// To parse this JSON data, do
//
//     final getNotificationRequest = getNotificationRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/get_notification_request.dart';

class GetNotificationRequestEntity extends GetNotificationRequest {
  GetNotificationRequestEntity({
    this.mobileUserId,
  }) : super(mobileUserId: mobileUserId);

  int mobileUserId;
}
