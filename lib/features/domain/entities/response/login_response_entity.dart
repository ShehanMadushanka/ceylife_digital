// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  LoginResponseEntity(
      {this.responseCode,
      this.responseError,
      this.mobileUserId,
      this.profile,
      this.lastLoginDate,
      this.unReadNotificationCount,this.leadGeneratorId});

  String responseCode;
  String responseError;
  String lastLoginDate;
  int unReadNotificationCount;
  int mobileUserId;
  int leadGeneratorId;
  ProfileEntity profile;

  factory LoginResponseEntity.fromRawJson(String str) =>
      LoginResponseEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      LoginResponseEntity(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        mobileUserId: json["mobileUserId"],
        lastLoginDate: json["lastLoginDate"],
        unReadNotificationCount: json["unReadNotificationCount"],
        profile: ProfileEntity.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "mobileUserId": mobileUserId,
        "lastLoginDate": lastLoginDate,
        "unReadNotificationCount": unReadNotificationCount,
        "profile": profile.toJson(),
      };

  @override
  List<Object> get props => [responseCode, responseError, mobileUserId];
}

class ProfileEntity extends Equatable {
  ProfileEntity(
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
      this.username,
      this.mobileUserId,
      this.leadGeneratorId,
      this.isLeadGenerator = false});

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
  bool isLeadGenerator;

  factory ProfileEntity.fromRawJson(String str) =>
      ProfileEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
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
        isLeadGenerator: json["isLeadGenerator"],
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
        "isLeadGenerator": isLeadGenerator,
      };

  @override
  List<Object> get props => [fullName, nickName, nicNo];
}
