// To parse this JSON data, do
//
//     final keyExchangeResponse = keyExchangeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class KeyExchangeResponseEntity extends Equatable{
  KeyExchangeResponseEntity({
    this.kcv,
    this.pmk,
    this.responseCode,
    this.responseError,
  });

  String kcv;
  String pmk;
  String responseCode;
  String responseError;

  @override
  List<Object> get props => [kcv, pmk];
}
