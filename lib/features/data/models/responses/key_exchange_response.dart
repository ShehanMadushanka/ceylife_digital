// To parse this JSON data, do
//
//     final keyExchangeResponse = keyExchangeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/key_exchange_response_entity.dart';

class KeyExchangeResponse extends KeyExchangeResponseEntity {
  KeyExchangeResponse({
    this.kcv,
    this.pmk,
    this.responseCode,
    this.responseError,
  }) : super(
            kcv: kcv,
            pmk: pmk,
            responseCode: responseCode,
            responseError: responseError);

  String kcv;
  String pmk;
  String responseCode;
  String responseError;

  factory KeyExchangeResponse.fromRawJson(String str) =>
      KeyExchangeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KeyExchangeResponse.fromJson(Map<String, dynamic> json) =>
      KeyExchangeResponse(
        kcv: json["KCV"],
        pmk: json["PMK"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "KCV": kcv,
        "PMK": pmk,
        "response_code": responseCode,
        "response_error": responseError,
      };
}
