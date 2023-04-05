// To parse this JSON data, do
//
//     final createUserRequest = createUserRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateUserRequest extends Equatable {
  CreateUserRequest(
      {this.email,
      this.nic,
      this.nickname,
      this.password,
      this.username,
      this.deviceId,
      this.mobileIMEINo,
      this.mobileManufacture,
      this.mobileModel,
      this.mobileOs,
      this.pushId});

  String email;
  String nic;
  String nickname;
  String password;
  String username;
  String deviceId;
  String pushId;
  String mobileIMEINo;
  String mobileOs;
  String mobileManufacture;
  String mobileModel;

  factory CreateUserRequest.fromRawJson(String str) =>
      CreateUserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      CreateUserRequest(
        email: json["email"],
        nic: json["nic"],
        nickname: json["nickname"],
        password: json["password"],
        username: json["username"],
        deviceId: json["deviceId"],
        pushId: json["pushId"],
        mobileIMEINo: json["mobileIMEINo"],
        mobileOs: json["mobileOs"],
        mobileManufacture: json["mobileManufacture"],
        mobileModel: json["mobileModel"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "nic": nic,
        "nickname": nickname,
        "password": password,
        "username": username,
        "deviceId": deviceId,
        "pushId": pushId,
        "mobileIMEINo": mobileIMEINo,
        "mobileOs": mobileOs,
        "mobileManufacture": mobileManufacture,
        "mobileModel": mobileModel,
      };

  @override
  List<Object> get props => [email, nic, nickname];
}
