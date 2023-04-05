// To parse this JSON data, do
//
//     final profileDataUpdateRequest = profileDataUpdateRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/profile_data_update_request.dart';

class ProfileDataUpdateRequestEntity extends ProfileDataUpdateRequest {
  ProfileDataUpdateRequestEntity({
    this.key,
    this.keyType,
    this.mobileUserId,
  }) : super(key: key, keyType: keyType, mobileUserId: mobileUserId);

  String key;
  int keyType;
  int mobileUserId;
}
