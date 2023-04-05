// To parse this JSON data, do
//
//     final customerInitiatedServiceResponse = customerInitiatedServiceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';

class CustomerInitiatedServiceResponse extends CustomerInitiatedServiceResponseEntity{
  CustomerInitiatedServiceResponse({
    this.responseCode,
    this.responseError,
    this.customerInitiatedServiceRequestDetailsObj,
  }):super(
    responseError: responseError,
    responseCode: responseCode,
    customerInitiatedServiceRequestDetails: customerInitiatedServiceRequestDetailsObj
  );

  String responseCode;
  String responseError;
  List<CustomerInitiatedServiceRequestDetail> customerInitiatedServiceRequestDetailsObj;

  factory CustomerInitiatedServiceResponse.fromRawJson(String str) => CustomerInitiatedServiceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedServiceResponse.fromJson(Map<String, dynamic> json) => CustomerInitiatedServiceResponse(
    responseCode: json["response_code"],
    responseError: json["response_error"],
    customerInitiatedServiceRequestDetailsObj: List<CustomerInitiatedServiceRequestDetail>.from(json["customerInitiatedServiceRequestDetails"].map((x) => CustomerInitiatedServiceRequestDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "response_error": responseError,
    "customerInitiatedServiceRequestDetails": List<dynamic>.from(customerInitiatedServiceRequestDetailsObj.map((x) => x.toJson())),
  };
}

class CustomerInitiatedServiceRequestDetail extends CustomerInitiatedServiceRequestDetailEntity{
  CustomerInitiatedServiceRequestDetail({
    this.customerInitiatedServiceRequestId,
    this.serviceRequestCategoryObj,
    this.serviceRequestMainCategoryObj,
    this.nicNo,
    this.comment = '',
    this.status,
    this.statusDescription,
    this.policyNo,
    this.remark = '',
    this.createdDate,
    this.lastUpdatedDate,
  }):super(
    status: status,
    policyNo: policyNo,
    comment: comment,
    createdDate: createdDate,
    customerInitiatedServiceRequestId: customerInitiatedServiceRequestId,
    lastUpdatedDate: lastUpdatedDate,
    nicNo: nicNo,
    remark: remark,
    serviceRequestCategory: serviceRequestCategoryObj,
    serviceRequestMainCategory: serviceRequestMainCategoryObj,
    statusDescription: statusDescription
  );

  int customerInitiatedServiceRequestId;
  ServiceRequestCategory serviceRequestCategoryObj;
  ServiceRequestMainCategory serviceRequestMainCategoryObj;
  String nicNo;
  String comment;
  String status;
  String statusDescription;
  String policyNo;
  String remark;
  String createdDate;
  String lastUpdatedDate;

  factory CustomerInitiatedServiceRequestDetail.fromRawJson(String str) => CustomerInitiatedServiceRequestDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInitiatedServiceRequestDetail.fromJson(Map<String, dynamic> json) => CustomerInitiatedServiceRequestDetail(
    customerInitiatedServiceRequestId: json["customerInitiatedServiceRequestId"],
    serviceRequestCategoryObj: ServiceRequestCategory.fromJson(json["serviceRequestCategory"]),
    serviceRequestMainCategoryObj: ServiceRequestMainCategory.fromJson(json["serviceRequestMainCategory"]),
    nicNo: json["nicNo"],
    comment: json["comment"]!=null?json["comment"]:'',
    status: json["status"],
    statusDescription: json["statusDescription"],
    policyNo: json["policyNo"],
    remark: json["remark"]!=null?json["remark"]:'',
    createdDate: json["createdDate"],
    lastUpdatedDate: json["lastUpdatedDate"],
  );

  Map<String, dynamic> toJson() => {
    "customerInitiatedServiceRequestId": customerInitiatedServiceRequestId,
    "serviceRequestCategory": serviceRequestCategoryObj.toJson(),
    "serviceRequestMainCategory": serviceRequestMainCategoryObj.toJson(),
    "nicNo": nicNo,
    "comment": comment,
    "status": status,
    "statusDescription": statusDescription,
    "policyNo": policyNo,
    "remark": remark,
    "createdDate": createdDate,
    "lastUpdatedDate": lastUpdatedDate,
  };
}

class ServiceRequestCategory extends ServiceRequestCategoryEntity{
  ServiceRequestCategory({
    this.serviceRequestCategoryId,
    this.description,
    this.status,
    this.fileUploadRequired,
    this.contactAdministrationRequired
  }):super(
    status: status,
    description: description,
    fileUploadRequired: fileUploadRequired,
    serviceRequestCategoryId: serviceRequestCategoryId,
    contactAdministrationRequired: contactAdministrationRequired
  );

  int serviceRequestCategoryId;
  String description;
  String status;
  bool fileUploadRequired;
  bool contactAdministrationRequired;

  factory ServiceRequestCategory.fromRawJson(String str) => ServiceRequestCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceRequestCategory.fromJson(Map<String, dynamic> json) => ServiceRequestCategory(
    serviceRequestCategoryId: json["serviceRequestCategoryId"],
    description: json["description"],
    status: json["status"],
    fileUploadRequired: json["isFileUploadRequired"],
    contactAdministrationRequired: json["isContactAdministrationRequired"],
  );

  Map<String, dynamic> toJson() => {
    "serviceRequestCategoryId": serviceRequestCategoryId,
    "description": description,
    "status": status,
    "isFileUploadRequired": fileUploadRequired,
    "isContactAdministrationRequired": contactAdministrationRequired,
  };
}

class ServiceRequestMainCategory extends ServiceRequestMainCategoryEntity{
  ServiceRequestMainCategory({
    this.serviceRequestMainCategoryId,
    this.mainCategory,
    this.status,
  }):super(
    status: status,
    mainCategory: mainCategory,
    serviceRequestMainCategoryId: serviceRequestMainCategoryId
  );

  int serviceRequestMainCategoryId;
  String mainCategory;
  String status;

  factory ServiceRequestMainCategory.fromRawJson(String str) => ServiceRequestMainCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceRequestMainCategory.fromJson(Map<String, dynamic> json) => ServiceRequestMainCategory(
    serviceRequestMainCategoryId: json["serviceRequestMainCategoryId"],
    mainCategory: json["mainCategory"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "serviceRequestMainCategoryId": serviceRequestMainCategoryId,
    "mainCategory": mainCategory,
    "status": status,
  };
}
