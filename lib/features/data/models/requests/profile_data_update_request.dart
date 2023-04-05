// To parse this JSON data, do
//
//     final profileDataUpdateRequest = profileDataUpdateRequestFromJson(jsonString);

import 'dart:convert';

class ProfileDataUpdateRequest {
  ProfileDataUpdateRequest({
    this.key,
    this.keyType,
    this.mobileUserId,
  });

  String key;
  int keyType;
  int mobileUserId;

  factory ProfileDataUpdateRequest.fromRawJson(String str) => ProfileDataUpdateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileDataUpdateRequest.fromJson(Map<String, dynamic> json) => ProfileDataUpdateRequest(
    key: json["key"],
    keyType: json["keyType"],
    mobileUserId: json["mobileUserId"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "keyType": keyType,
    "mobileUserId": mobileUserId,
  };
}
