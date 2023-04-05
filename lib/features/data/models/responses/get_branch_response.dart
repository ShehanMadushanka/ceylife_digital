// To parse this JSON data, do
//
//     final getBranchResponse = getBranchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/utils/string_util.dart';

class GetBranchResponse extends BranchResponseEntity {
  GetBranchResponse({
    this.responseCode,
    this.responseError,
    this.data,
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            branches: data);

  String responseCode;
  String responseError;
  List<BranchData> data;

  factory GetBranchResponse.fromRawJson(String str) =>
      GetBranchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBranchResponse.fromJson(Map<String, dynamic> json) =>
      GetBranchResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["data"] != null
            ? List<BranchData>.from(
                json["data"].map((x) => BranchData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BranchData extends BranchEntity {
  BranchData({
    this.serviceProviderId,
    this.providerType,
    this.country,
    this.masterRegion,
    this.subRegion,
    this.name,
    this.address,
    this.contactNo,
    this.status,
    this.lastUpdatedTime,
    this.longitude,
    this.latitude,
    this.openingHoursMonFri,
    this.openingHoursSat,
    this.openingHoursSun,
  }) : super(
          serviceProviderId: serviceProviderId,
          title: name,
          contact: contactNo,
          availableTime: StringUtils.generateBranchAvailableTime(
              openingHoursMonFri, openingHoursSat, openingHoursSun),
          address: address,
          latitude: latitude,
          longitude: longitude,
        );

  int serviceProviderId;
  String providerType;
  String country;
  String masterRegion;
  String subRegion;
  String name;
  String address;
  String contactNo;
  String status;
  String lastUpdatedTime;
  String longitude;
  String latitude;
  String openingHoursMonFri;
  String openingHoursSat;
  String openingHoursSun;

  factory BranchData.fromRawJson(String str) =>
      BranchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
        serviceProviderId: json["serviceProviderId"],
        providerType: json["providerType"],
        country: json["country"],
        masterRegion: json["masterRegion"],
        subRegion: json["subRegion"],
        name: json["name"],
        address: json["address"],
        contactNo: json["contactNo"],
        status: json["status"],
        lastUpdatedTime: json["lastUpdatedTime"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        openingHoursMonFri: json["openingHoursMonFri"],
        openingHoursSat: json["openingHoursSat"],
        openingHoursSun: json["openingHoursSun"],
      );

  Map<String, dynamic> toJson() => {
        "serviceProviderId": serviceProviderId,
        "providerType": providerType,
        "country": country,
        "masterRegion": masterRegion,
        "subRegion": subRegion,
        "name": name,
        "address": address,
        "contactNo": contactNo,
        "status": status,
        "lastUpdatedTime": lastUpdatedTime,
        "longitude": longitude,
        "latitude": latitude,
        "openingHoursMonFri": openingHoursMonFri,
        "openingHoursSat": openingHoursSat,
        "openingHoursSun": openingHoursSun,
      };
}
