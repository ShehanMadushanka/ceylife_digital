// To parse this JSON data, do
//
//     final splashResponse = splashResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SplashResponseEntity extends Equatable {
  SplashResponseEntity({
    this.responseCode,
    this.responseError,
    this.configurationData,
  });

  String responseCode;
  String responseError;
  ConfigurationDataEntity configurationData;

  @override
  List<Object> get props => [responseError, responseCode, configurationData];
}

class ConfigurationDataEntity extends Equatable {
  ConfigurationDataEntity(
      {this.passwordPolicy, this.otpServiceTimeout, this.buyOnlineWebLinks});

  PasswordPolicyEntity passwordPolicy;
  int otpServiceTimeout;
  List<BuyOnlineWebLinkEntity> buyOnlineWebLinks;

  factory ConfigurationDataEntity.fromRawJson(String str) =>
      ConfigurationDataEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigurationDataEntity.fromJson(Map<String, dynamic> json) =>
      ConfigurationDataEntity(
        passwordPolicy: PasswordPolicyEntity.fromJson(json["passwordPolicy"]),
        otpServiceTimeout: json["otpServiceTimeout"],
        buyOnlineWebLinks: json["buyOnlineWebLinks"] == null
            ? List.empty()
            : List<BuyOnlineWebLinkEntity>.from(json["buyOnlineWebLinks"]
                .map((x) => BuyOnlineWebLinkEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "passwordPolicy": passwordPolicy.toJson(),
        "otpServiceTimeout": otpServiceTimeout,
        "buyOnlineWebLinks":
            List<dynamic>.from(buyOnlineWebLinks.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [passwordPolicy, otpServiceTimeout];
}

class PasswordPolicyEntity extends Equatable {
  PasswordPolicyEntity({
    this.maxLength,
    this.minLength,
    this.minNumChars,
    this.minSpecialChars,
    this.minLowerChars,
    this.minUpperChars,
    this.specialChars,
  });

  int maxLength;
  int minLength;
  int minNumChars;
  int minSpecialChars;
  int minLowerChars;
  int minUpperChars;
  String specialChars;

  factory PasswordPolicyEntity.fromRawJson(String str) =>
      PasswordPolicyEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordPolicyEntity.fromJson(Map<String, dynamic> json) =>
      PasswordPolicyEntity(
        maxLength: json["maxLength"],
        minLength: json["minLength"],
        minNumChars: json["minNumChars"],
        minSpecialChars: json["minSpecialChars"],
        minLowerChars: json["minLowerChars"],
        minUpperChars: json["minUpperChars"],
        specialChars: json["specialChars"],
      );

  Map<String, dynamic> toJson() => {
        "maxLength": maxLength,
        "minLength": minLength,
        "minNumChars": minNumChars,
        "minSpecialChars": minSpecialChars,
        "minLowerChars": minLowerChars,
        "minUpperChars": minUpperChars,
        "specialChars": specialChars,
      };

  @override
  List<Object> get props => [maxLength, minLowerChars, minSpecialChars];
}

class BuyOnlineWebLinkEntity extends Equatable {
  BuyOnlineWebLinkEntity({
    this.code,
    this.link,
  });

  String code;
  String link;

  factory BuyOnlineWebLinkEntity.fromRawJson(String str) =>
      BuyOnlineWebLinkEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyOnlineWebLinkEntity.fromJson(Map<String, dynamic> json) =>
      BuyOnlineWebLinkEntity(
        code: json["code"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "link": link,
      };

  @override
  List<Object> get props => [code, link];
}
