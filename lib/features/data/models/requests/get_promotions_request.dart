// To parse this JSON data, do
//
//     final getPromotionsRequest = getPromotionsRequestFromJson(jsonString);

import 'dart:convert';

class GetPromotionsRequest {
  GetPromotionsRequest({
    this.promotionType,
  });

  String promotionType;

  factory GetPromotionsRequest.fromRawJson(String str) => GetPromotionsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPromotionsRequest.fromJson(Map<String, dynamic> json) => GetPromotionsRequest(
    promotionType: json["promotionType"],
  );

  Map<String, dynamic> toJson() => {
    "promotionType": promotionType,
  };
}
