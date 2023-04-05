import 'dart:convert';

class ConfigurationData{
  ConfigurationData(
      {this.passwordPolicy,
        this.otpServiceTimeout,
        this.buyOnlineWebLinks});

  PasswordPolicy passwordPolicy;
  int otpServiceTimeout;
  List<BuyOnlineWebLink> buyOnlineWebLinks;

  factory ConfigurationData.fromRawJson(String str) =>
      ConfigurationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigurationData.fromJson(Map<String, dynamic> json) =>
      ConfigurationData(
        passwordPolicy: json["passwordPolicy"] != null
            ? PasswordPolicy.fromJson(json["passwordPolicy"])
            : PasswordPolicy(),
        otpServiceTimeout: json["otpServiceTimeout"],
        buyOnlineWebLinks: json["buyOnlineWebLinks"] == null
            ? List.empty()
            : List<BuyOnlineWebLink>.from(json["buyOnlineWebLinks"]
            .map((x) => BuyOnlineWebLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "passwordPolicy": passwordPolicy.toJson(),
    "otpServiceTimeout": otpServiceTimeout,
    "buyOnlineWebLinks":
    List<dynamic>.from(buyOnlineWebLinks.map((x) => x.toJson())),
  };
}

class BuyOnlineWebLink {
  BuyOnlineWebLink({
    this.code,
    this.link,
  });

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

class PasswordPolicy {
  PasswordPolicy({
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