// To parse this JSON data, do
//
//     final accumulationRateHistoryResponse = accumulationRateHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/accumulation_rate_history_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';

class AccumulationRateHistoryResponse
    extends AccumulationRateHistoryResponseEntity {
  AccumulationRateHistoryResponse({
    this.responseCode,
    this.responseError,
    this.ratesObj,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            rates: ratesObj);

  String responseCode;
  String responseError;
  List<Rate> ratesObj;

  factory AccumulationRateHistoryResponse.fromRawJson(String str) =>
      AccumulationRateHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccumulationRateHistoryResponse.fromJson(Map<String, dynamic> json) =>
      AccumulationRateHistoryResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        ratesObj: json["rates"] != null
            ? List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "rates": List<dynamic>.from(ratesObj.map((x) => x.toJson())),
      };
}

class Rate extends RateEntity {
  Rate({
    this.rateId,
    this.rate,
    this.createdTime,
  }) : super(rateId: rateId, rate: rate, createdTime: createdTime);

  int rateId;
  String rate;
  String createdTime;

  factory Rate.fromRawJson(String str) => Rate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        rateId: json["rateId"],
        rate: json["rate"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "rateId": rateId,
        "rate": rate,
        "createdTime": createdTime,
      };
}
