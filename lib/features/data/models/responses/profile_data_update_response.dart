// To parse this JSON data, do
//
//     final profileDataUpdateResponse = profileDataUpdateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/profile_data_update_response_entity.dart';

class ProfileDataUpdateResponse extends ProfileDataUpdateResponseEntity {
  ProfileDataUpdateResponse({
    this.responseCode,
    this.responseError,
    this.data,
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            data: data);

  String responseCode;
  String responseError;
  String data;

  factory ProfileDataUpdateResponse.fromRawJson(String str) =>
      ProfileDataUpdateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileDataUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileDataUpdateResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["profilePictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "profilePictureUrl": data,
      };
}
