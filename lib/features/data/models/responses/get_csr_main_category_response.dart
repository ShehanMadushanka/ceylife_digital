// To parse this JSON data, do
//
//     final getCsrMainCategoryResponse = getCsrMainCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';

class GetCsrMainCategoryResponse extends GetCsrMainCategoryResponseEntity {
  GetCsrMainCategoryResponse({
    this.responseCode,
    this.responseError,
    this.serviceRequestMainCategories,
  }) : super(
            resError: responseError,
            resCode: responseCode,
            serviceRequestMainCategoriesEntity: serviceRequestMainCategories);

  String responseCode;
  String responseError;
  List<ServiceRequestMainCategory> serviceRequestMainCategories;

  factory GetCsrMainCategoryResponse.fromRawJson(String str) =>
      GetCsrMainCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCsrMainCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetCsrMainCategoryResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        serviceRequestMainCategories:
            json["serviceRequestMainCategories"] != null
                ? List<ServiceRequestMainCategory>.from(
                    json["serviceRequestMainCategories"]
                        .map((x) => ServiceRequestMainCategory.fromJson(x)))
                : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "serviceRequestMainCategories": List<dynamic>.from(
            serviceRequestMainCategories.map((x) => x.toJson())),
      };
}

class ServiceRequestMainCategory extends ServiceRequestMainCategoryEntity {
  ServiceRequestMainCategory({
    this.mainCategory,
    this.serviceRequestMainCategoryId,
    this.status,
  }) : super(
            serviceRequestMainCategoryId: serviceRequestMainCategoryId,
            status: status,
            mainCategory: mainCategory);

  String mainCategory;
  int serviceRequestMainCategoryId;
  String status;

  factory ServiceRequestMainCategory.fromRawJson(String str) =>
      ServiceRequestMainCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceRequestMainCategory.fromJson(Map<String, dynamic> json) =>
      ServiceRequestMainCategory(
        mainCategory: json["mainCategory"],
        serviceRequestMainCategoryId: json["serviceRequestMainCategoryId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "mainCategory": mainCategory,
        "serviceRequestMainCategoryId": serviceRequestMainCategoryId,
        "status": status,
      };
}
