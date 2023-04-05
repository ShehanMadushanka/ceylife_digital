// To parse this JSON data, do
//
//     final splashRequest = splashRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SplashRequest extends Equatable {
  SplashRequest({
    this.appHash,
    this.buildVersion,
    this.os,
    this.pushId,
    this.versionNumber,
  });

  String appHash;
  String buildVersion;
  String os;
  String pushId;
  String versionNumber;

  factory SplashRequest.fromRawJson(String str) =>
      SplashRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SplashRequest.fromJson(Map<String, dynamic> json) => SplashRequest(
        appHash: json["appHash"],
        buildVersion: json["buildVersion"],
        os: json["os"],
        pushId: json["pushId"],
        versionNumber: json["versionNumber"],
      );

  Map<String, dynamic> toJson() => {
        "appHash": appHash,
        "buildVersion": buildVersion,
        "os": os,
        "pushId": pushId,
        "versionNumber": versionNumber,
      };

  @override
  List<Object> get props => [appHash, buildVersion, os, pushId, versionNumber];
}
