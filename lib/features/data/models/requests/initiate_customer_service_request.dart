// To parse this JSON data, do
//
//     final initiateCustomerServiceRequest = initiateCustomerServiceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class InitiateCustomerServiceRequest extends Equatable{
  InitiateCustomerServiceRequest({
    this.mobileUserId,
    this.policyNo,
    this.serviceRequestMainCategoryId,
    this.serviceRequestCategoryId,
    this.comment,
    this.uploadFiles,
  });

  int mobileUserId;
  String policyNo;
  int serviceRequestMainCategoryId;
  int serviceRequestCategoryId;
  String comment;
  List<FileElement> uploadFiles;

  factory InitiateCustomerServiceRequest.fromRawJson(String str) => InitiateCustomerServiceRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InitiateCustomerServiceRequest.fromJson(Map<String, dynamic> json) => InitiateCustomerServiceRequest(
    mobileUserId: json["mobileUserId"],
    policyNo: json["policyNo"],
    serviceRequestMainCategoryId: json["serviceRequestMainCategoryId"],
    serviceRequestCategoryId: json["serviceRequestCategoryId"],
    comment: json["comment"],
    uploadFiles: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mobileUserId": mobileUserId,
    "policyNo": policyNo,
    "serviceRequestMainCategoryId": serviceRequestMainCategoryId,
    "serviceRequestCategoryId": serviceRequestCategoryId,
    "comment": comment,
    "files": List<dynamic>.from(uploadFiles.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [mobileUserId, serviceRequestMainCategoryId, serviceRequestCategoryId];
}

class FileElement extends Equatable{
  FileElement({
    this.fileType,
    this.encodedFile,
  });

  String fileType;
  String encodedFile;

  factory FileElement.fromRawJson(String str) => FileElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    fileType: json["fileType"],
    encodedFile: json["encodedFile"],
  );

  Map<String, dynamic> toJson() => {
    "fileType": fileType,
    "encodedFile": encodedFile,
  };

  @override
  List<Object> get props => [fileType, encodedFile];
}
