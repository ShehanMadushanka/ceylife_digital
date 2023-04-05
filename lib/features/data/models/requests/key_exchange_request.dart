// To parse this JSON data, do
//
//     final keyExchangeRequest = keyExchangeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class KeyExchangeRequest extends Equatable{
  KeyExchangeRequest({
    this.key,
  });

  String key;

  factory KeyExchangeRequest.fromRawJson(String str) => KeyExchangeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KeyExchangeRequest.fromJson(Map<String, dynamic> json) => KeyExchangeRequest(
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
  };

  @override
  List<Object> get props => [key];
}
