

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/get_banks_response_entity.dart';


class BanksResponse extends BanksResponseEntity {
  BanksResponse({
    this.getBanks,
    this.responseCode,
    this.responseError,
  
  }) : super(
      responseError: responseError,
      responseCode: responseCode,
      banks: getBanks);

  List<GetBanks> getBanks;
 
  String responseCode;
  String responseError;


  factory BanksResponse.fromRawJson(String str) =>
      BanksResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BanksResponse.fromJson(Map<String, dynamic> json) =>
      BanksResponse(
        getBanks: json["banks"] != null
            ? List<GetBanks>.from(
            json["banks"].map((x) => GetBanks.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
    "banks": List<dynamic>.from(getBanks.map((x) => x.toJson())),
    "response_code": responseCode,
    "response_error": responseError,
  };
}

class GetBanks extends BanksEntity {
  GetBanks({
    this.bankCode,
    this.bankName,
    this.createdTime,
    this.lastUpdatedTime,
    this.status
  }) : super(
      bankCode: bankCode,
      bankName: bankName,
      createdTime: createdTime,
      lastUpdatedTime: lastUpdatedTime,
  status: status);

 String bankCode;
  String bankName;
  String createdTime;
  String lastUpdatedTime;
  String status;

  factory GetBanks.fromRawJson(String str) =>
      GetBanks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBanks.fromJson(Map<String, dynamic> json) => GetBanks(
    bankCode:json["bankCode"],
    bankName: json["bankName"],
    createdTime: json["createdTime"],
    lastUpdatedTime:json["lastUpdatedTime"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bankCode":bankCode,
    "bankName":bankName,
    "createdTime":createdTime,
    "lastUpdatedTime":lastUpdatedTime,
    "status": status,
  };
}

