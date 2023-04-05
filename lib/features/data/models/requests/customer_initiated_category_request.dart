// To parse this JSON data, do
//
//     final customerInitiatedCategoryRequest = customerInitiatedCategoryRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerInitiatedCategoryRequest extends Equatable{
  CustomerInitiatedCategoryRequest({
    this.mainCategoryId,
  });

  int mainCategoryId;

  factory CustomerInitiatedCategoryRequest.fromRawJson(String str) => CustomerInitiatedCategoryRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedCategoryRequest.fromJson(Map<String, dynamic> json) => CustomerInitiatedCategoryRequest(
    mainCategoryId: json["mainCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "mainCategoryId": mainCategoryId,
  };

  @override
  List<Object> get props => [mainCategoryId];
}
