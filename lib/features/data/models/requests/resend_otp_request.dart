import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResendOtpRequest extends Equatable {
  final String key;
  final int keyType;

  ResendOtpRequest({this.key, this.keyType});

  factory ResendOtpRequest.fromRawJson(String str) =>
      ResendOtpRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      ResendOtpRequest(
        key: json["key"],
        keyType: json["keyType"],
      );

  Map<String, dynamic> toJson() => {"key": key, "keyType": keyType};

  @override
  List<Object> get props => [key, keyType];
}
