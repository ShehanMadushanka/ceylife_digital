// To parse this JSON data, do
//
//     final getPromotionsRequest = getPromotionsRequestFromJson(jsonString);

import 'dart:convert';

class GetBranchesRequest {
  GetBranchesRequest({
    this.categoryCode,
  });

  String categoryCode;

  factory GetBranchesRequest.fromRawJson(String str) => GetBranchesRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBranchesRequest.fromJson(Map<String, dynamic> json) => GetBranchesRequest(
    categoryCode: json["branchType"],
  );

  Map<String, dynamic> toJson() => {
    "branchType": categoryCode,
  };
}
