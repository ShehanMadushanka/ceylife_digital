// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetLoginRequest extends Equatable {
  GetLoginRequest({
    this.deviceId,
    this.mobileImeiNo,
    this.mobileManufacture,
    this.mobileModel,
    this.mobileOs,
    this.password,
    this.pushId,
    this.username,
    this.signInMode
  });

  String deviceId;
  String mobileImeiNo;
  String mobileManufacture;
  String mobileModel;
  String mobileOs;
  String password;
  String pushId;
  String username;
  String signInMode;

  factory GetLoginRequest.fromRawJson(String str) =>
      GetLoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLoginRequest.fromJson(Map<String, dynamic> json) =>
      GetLoginRequest(
        deviceId: json["deviceId"],
        mobileImeiNo: json["mobileIMEINo"],
        mobileManufacture: json["mobileManufacture"],
        mobileModel: json["mobileModel"],
        mobileOs: json["mobileOs"],
        password: json["password"],
        pushId: json["pushId"],
        username: json["username"],
        signInMode: json["signInMode"],
      );

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "mobileIMEINo": mobileImeiNo,
        "mobileManufacture": mobileManufacture,
        "mobileModel": mobileModel,
        "mobileOs": mobileOs,
        "password": password,
        "pushId": pushId,
        "username": username,
        "signInMode": signInMode,
      };

  @override
  List<Object> get props => [deviceId, mobileImeiNo, username];
}
