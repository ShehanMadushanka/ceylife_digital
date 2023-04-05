// To parse this JSON data, do
//
//     final initiateCustomerServiceRequest = initiateCustomerServiceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/data/models/requests/initiate_customer_service_request.dart';

class InitiateCustomerServiceRequestEntity extends InitiateCustomerServiceRequest{
  InitiateCustomerServiceRequestEntity({
    this.mobileUserId,
    this.policyNo,
    this.serviceRequestMainCategoryId,
    this.serviceRequestCategoryId,
    this.comment,
    this.files,
  }):super(
    mobileUserId: mobileUserId,
    uploadFiles: files,
    policyNo: policyNo,
    comment: comment,
    serviceRequestCategoryId: serviceRequestCategoryId,
    serviceRequestMainCategoryId: serviceRequestMainCategoryId
  );

  int mobileUserId;
  String policyNo;
  int serviceRequestMainCategoryId;
  int serviceRequestCategoryId;
  String comment;
  List<FileElementEntity> files;
}

class FileElementEntity extends FileElement {
  FileElementEntity({
    this.fileType,
    this.encodedFile,
  }):super(
    fileType: fileType,
    encodedFile: encodedFile
  );

  String fileType;
  String encodedFile;
}
