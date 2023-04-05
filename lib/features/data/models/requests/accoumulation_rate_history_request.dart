// To parse this JSON data, do
//
//     final accumulationRateHistoryRequest = accumulationRateHistoryRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccumulationRateHistoryRequest extends Equatable{
  AccumulationRateHistoryRequest({
    this.productDetailId,
  });

  int productDetailId;

  factory AccumulationRateHistoryRequest.fromRawJson(String str) => AccumulationRateHistoryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccumulationRateHistoryRequest.fromJson(Map<String, dynamic> json) => AccumulationRateHistoryRequest(
    productDetailId: json["productDetailId"],
  );

  Map<String, dynamic> toJson() => {
    "productDetailId": productDetailId,
  };

  @override
  List<Object> get props => [productDetailId];
}
