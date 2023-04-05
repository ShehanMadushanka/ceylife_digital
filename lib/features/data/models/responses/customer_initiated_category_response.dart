// To parse this JSON data, do
//
//     final customerInitiatedCategoryResponse = customerInitiatedCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';

class CustomerInitiatedCategoryResponse
    extends CustomerInitiatedCategoryResponseEntity {
  CustomerInitiatedCategoryResponse({
    this.responseCode,
    this.responseError,
    this.serviceRequestCategoriesObj,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            serviceRequestCategories: serviceRequestCategoriesObj);

  String responseCode;
  String responseError;
  List<ServiceRequestCategoryResponseData> serviceRequestCategoriesObj;

  factory CustomerInitiatedCategoryResponse.fromRawJson(String str) =>
      CustomerInitiatedCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedCategoryResponse.fromJson(
          Map<String, dynamic> json) =>
      CustomerInitiatedCategoryResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        serviceRequestCategoriesObj: json["serviceRequestCategories"] != null
            ? List<ServiceRequestCategoryResponseData>.from(json["serviceRequestCategories"]
                .map((x) => ServiceRequestCategoryResponseData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "serviceRequestCategories": List<dynamic>.from(
            serviceRequestCategoriesObj.map((x) => x.toJson())),
      };
}

class ServiceRequestCategoryResponseData extends ServiceRequestCategoryEntity {
  ServiceRequestCategoryResponseData({
    this.description,
    this.serviceRequestCategoryId,
    this.fileUploadRequired,
    this.status,
    this.isContactAdministrationRequired
  }) : super(
            status: status,
            description: description,
            serviceRequestCategoryId: serviceRequestCategoryId,
      contactAdministrationRequired: isContactAdministrationRequired,
      fileUploadRequired: fileUploadRequired);

  String description;
  int serviceRequestCategoryId;
  bool fileUploadRequired;
  bool isContactAdministrationRequired;
  String status;

  factory ServiceRequestCategoryResponseData.fromRawJson(String str) =>
      ServiceRequestCategoryResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceRequestCategoryResponseData.fromJson(Map<String, dynamic> json) =>
      ServiceRequestCategoryResponseData(
        description: json["description"],
        serviceRequestCategoryId: json["serviceRequestCategoryId"],
        fileUploadRequired: json["isFileUploadRequired"],
        isContactAdministrationRequired: json["isContactAdministrationRequired"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "serviceRequestCategoryId": serviceRequestCategoryId,
        "isFileUploadRequired": fileUploadRequired,
        "isContactAdministrationRequired": isContactAdministrationRequired,
        "status": status,
      };
}
