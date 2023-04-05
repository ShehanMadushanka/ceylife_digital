// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';

class GetLoginResponse extends LoginResponseEntity {
  GetLoginResponse(
      {this.responseCode,
      this.responseError,
      this.mobileUserId,
      this.profileObj,
      this.lastLoginDate,
      this.unReadNotificationCount,
      this.leadGeneratorId})
      : super(
            profile: profileObj,
            responseError: responseError,
            mobileUserId: mobileUserId,
            leadGeneratorId: leadGeneratorId,
            responseCode: responseCode,
            lastLoginDate: lastLoginDate,
            unReadNotificationCount: unReadNotificationCount);

  String responseCode;
  String responseError;
  String lastLoginDate;
  int unReadNotificationCount;
  int mobileUserId;
  int leadGeneratorId;
  Profile profileObj;

  factory GetLoginResponse.fromRawJson(String str) =>
      GetLoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLoginResponse.fromJson(Map<String, dynamic> json) =>
      GetLoginResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        mobileUserId: json["mobileUserId"],
        leadGeneratorId: json["leadGeneratorId"],
        lastLoginDate: json["lastLoginDate"],
        unReadNotificationCount: json["unReadNotificationCount"],
        profileObj: json["profile"] != null
            ? Profile.fromJson(json["profile"])
            : Profile(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "mobileUserId": mobileUserId,
        "leadGeneratorId": leadGeneratorId,
        "lastLoginDate": lastLoginDate,
        "unReadNotificationCount": unReadNotificationCount,
        "profile": profile.toJson(),
      };
}

class Profile extends ProfileEntity {
  Profile(
      {this.fullName,
      this.nickName,
      this.email,
      this.nicNo,
      this.dateOfBirth,
      this.mobileNo,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.profilePictureUrl,
      this.mobileUserId,
      this.username,
      this.leadGeneratorId})
      : super(
            mobileNo: mobileNo,
            city: city,
            email: email,
            dateOfBirth: dateOfBirth,
            fullName: fullName,
            nicNo: nicNo,
            profilePictureUrl: profilePictureUrl,
            nickName: nickName,
            mobileUserId: mobileUserId,
            leadGeneratorId: leadGeneratorId,
            username: username,
            addressLine2: addressLine2,
            addressLine1: addressLine1);

  String fullName;
  String nickName;
  String email;
  String nicNo;
  String dateOfBirth;
  String mobileNo;
  String addressLine1;
  String addressLine2;
  String city;
  String profilePictureUrl;
  String username;
  int mobileUserId;
  int leadGeneratorId;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        fullName: json["fullName"],
        nickName: json["nickName"],
        email: json["email"],
        nicNo: json["nicNo"],
        dateOfBirth: json["dateOfBirth"],
        mobileNo: json["mobileNo"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        profilePictureUrl: json["profilePictureUrl"],
        username: json["username"],
        mobileUserId: json["mobileUserId"],
        leadGeneratorId: json["leadGeneratorId"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "nickName": nickName,
        "email": email,
        "nicNo": nicNo,
        "dateOfBirth": dateOfBirth,
        "mobileNo": mobileNo,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "profilePictureUrl": profilePictureUrl,
        "username": username,
        "mobileUserId": mobileUserId,
        "leadGeneratorId": leadGeneratorId,
      };
}
