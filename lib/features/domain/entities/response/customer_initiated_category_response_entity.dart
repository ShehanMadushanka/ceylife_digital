// To parse this JSON data, do
//
//     final customerInitiatedCategoryResponse = customerInitiatedCategoryResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class CustomerInitiatedCategoryResponseEntity extends Equatable {
  CustomerInitiatedCategoryResponseEntity({
    this.responseCode,
    this.responseError,
    this.serviceRequestCategories,
  });

  String responseCode;
  String responseError;
  List<ServiceRequestCategoryEntity> serviceRequestCategories;

  @override
  List<Object> get props =>
      [responseCode, responseError, serviceRequestCategories];
}

class ServiceRequestCategoryEntity extends Equatable {
  ServiceRequestCategoryEntity({
    this.description,
    this.serviceRequestCategoryId,
    this.fileUploadRequired,
    this.status,
    this.contactAdministrationRequired,
    this.isContactAdministrationRequired
  });

  String description;
  int serviceRequestCategoryId;
  bool fileUploadRequired;
  bool isContactAdministrationRequired;
  bool contactAdministrationRequired;
  String status;

  @override
  List<Object> get props =>
      [description, serviceRequestCategoryId, fileUploadRequired, status];
}
