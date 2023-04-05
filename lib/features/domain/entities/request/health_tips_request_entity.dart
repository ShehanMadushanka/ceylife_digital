// To parse this JSON data, do
//
//     final healthTipsRequest = healthTipsRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/health_tips_request.dart';

class HealthTipsRequestEntity extends HealthTipsRequest {
  HealthTipsRequestEntity({
    this.mobileUserId,
  }) : super(mobileUserId: mobileUserId);

  int mobileUserId;
}
