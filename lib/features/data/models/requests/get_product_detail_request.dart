// To parse this JSON data, do
//
//     final getPromotionsRequest = getPromotionsRequestFromJson(jsonString);

import 'dart:convert';

class GetProductDetailRequest {
  GetProductDetailRequest({
    this.categoryCode,
  });

  String categoryCode;

  factory GetProductDetailRequest.fromRawJson(String str) => GetProductDetailRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProductDetailRequest.fromJson(Map<String, dynamic> json) => GetProductDetailRequest(
    categoryCode: json["categoryCode"],
  );

  Map<String, dynamic> toJson() => {
    "categoryCode": categoryCode,
  };
}
