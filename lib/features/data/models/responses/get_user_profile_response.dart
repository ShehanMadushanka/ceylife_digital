// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/user_profile_response_entity.dart';

class UserProfileResponse extends UserProfileResponseEntity {
  UserProfileResponse({
    this.profileObj,
    this.profilePictureUrl,
    this.responseCode,
    this.responseError,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            profile: profileObj,
            profilePictureUrl: profilePictureUrl);

  ProfileObj profileObj;
  String profilePictureUrl;
  String responseCode;
  String responseError;

  factory UserProfileResponse.fromRawJson(String str) =>
      UserProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        profileObj: json["profile"] == null
            ? ProfileObj()
            : ProfileObj.fromJson(json["profile"]),
        profilePictureUrl: json["profilePictureUrl"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profileObj.toJson(),
        "profilePictureUrl": profilePictureUrl,
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class ProfileObj extends Profile {
  ProfileObj({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.dateOfBirth,
    this.email,
    this.fullName,
    this.mobileNo,
    this.nicNo,
    this.nickName,
    this.profilePictureUrl,
  }) : super(
            addressLine1: addressLine1,
            addressLine2: addressLine2,
            city: city,
            profilePictureUrl: profilePictureUrl,
            email: email,
            nickName: nickName,
            mobileNo: mobileNo,
            nicNo: nicNo,
            dateOfBirth: dateOfBirth,
            fullName: fullName);

  String addressLine1;
  String addressLine2;
  String city;
  String dateOfBirth;
  String email;
  String fullName;
  String mobileNo;
  String nicNo;
  String nickName;
  String profilePictureUrl;

  factory ProfileObj.fromRawJson(String str) =>
      ProfileObj.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileObj.fromJson(Map<String, dynamic> json) => ProfileObj(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        dateOfBirth: json["dateOfBirth"],
        email: json["email"],
        fullName: json["fullName"],
        mobileNo: json["mobileNo"],
        nicNo: json["nicNo"],
        nickName: json["nickName"],
        profilePictureUrl: json["profilePictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "dateOfBirth": dateOfBirth,
        "email": email,
        "fullName": fullName,
        "mobileNo": mobileNo,
        "nicNo": nicNo,
        "nickName": nickName,
        "profilePictureUrl": profilePictureUrl,
      };
}
