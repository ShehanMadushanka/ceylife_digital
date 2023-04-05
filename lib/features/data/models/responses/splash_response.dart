// To parse this JSON data, do
//
//     final splashResponse = splashResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';

class SplashResponse extends SplashResponseEntity {
  SplashResponse({
    this.responseCode,
    this.responseError,
    this.configurationDataObj,
  }) : super(
            configurationData: configurationDataObj,
            responseError: responseError,
            responseCode: responseCode);

  String responseCode;
  String responseError;
  ConfigurationData configurationDataObj;

  factory SplashResponse.fromRawJson(String str) =>
      SplashResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SplashResponse.fromJson(Map<String, dynamic> json) => SplashResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        configurationDataObj: json["configurationData"] != null
            ? ConfigurationData.fromJson(json["configurationData"])
            : ConfigurationData(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "configurationData": configurationDataObj.toJson(),
      };
}

class ConfigurationData extends ConfigurationDataEntity {
  ConfigurationData(
      {this.passwordPolicyObj,
      this.otpServiceTimeout,
      this.buyOnlineWebLinksList})
      : super(
            passwordPolicy: passwordPolicyObj,
            otpServiceTimeout: otpServiceTimeout);

  PasswordPolicy passwordPolicyObj;
  int otpServiceTimeout;
  List<BuyOnlineWebLink> buyOnlineWebLinksList;

  factory ConfigurationData.fromRawJson(String str) =>
      ConfigurationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigurationData.fromJson(Map<String, dynamic> json) =>
      ConfigurationData(
        passwordPolicyObj: json["passwordPolicy"] != null
            ? PasswordPolicy.fromJson(json["passwordPolicy"])
            : PasswordPolicy(),
        otpServiceTimeout: json["otpServiceTimeout"],
        buyOnlineWebLinksList: json["buyOnlineWebLinks"] == null
            ? List.empty()
            : List<BuyOnlineWebLink>.from(json["buyOnlineWebLinks"]
                .map((x) => BuyOnlineWebLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "passwordPolicy": passwordPolicyObj.toJson(),
        "otpServiceTimeout": otpServiceTimeout,
        "buyOnlineWebLinks":
            List<dynamic>.from(buyOnlineWebLinksList.map((x) => x.toJson())),
      };
}

class BuyOnlineWebLink extends BuyOnlineWebLinkEntity {
  BuyOnlineWebLink({
    this.code,
    this.link,
  }) : super(code: code, link: link);

  String code;
  String link;

  factory BuyOnlineWebLink.fromRawJson(String str) =>
      BuyOnlineWebLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuyOnlineWebLink.fromJson(Map<String, dynamic> json) =>
      BuyOnlineWebLink(
        code: json["code"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "link": link,
      };
}

class PasswordPolicy extends PasswordPolicyEntity {
  PasswordPolicy({
    this.maxLength,
    this.minLength,
    this.minNumChars,
    this.minSpecialChars,
    this.minLowerChars,
    this.minUpperChars,
    this.specialChars,
  }) : super(
            minLowerChars: minLowerChars,
            specialChars: specialChars,
            minUpperChars: minUpperChars,
            minSpecialChars: minSpecialChars,
            minNumChars: minNumChars,
            minLength: minLength,
            maxLength: maxLength);

  int maxLength;
  int minLength;
  int minNumChars;
  int minSpecialChars;
  int minLowerChars;
  int minUpperChars;
  String specialChars;

  factory PasswordPolicy.fromRawJson(String str) =>
      PasswordPolicy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordPolicy.fromJson(Map<String, dynamic> json) => PasswordPolicy(
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
}
