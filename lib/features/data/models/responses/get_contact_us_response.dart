// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';

ContactUsResponse contactResponseFromJson(String str) =>
    ContactUsResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactUsResponse data) =>
    json.encode(data.toJson());

class ContactUsResponse {
  ContactUsResponse({
    this.responseCode,
    this.responseError,
    this.data,
  });

  String responseCode;
  String responseError;
  List<ContactUsData> data;

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["data"] != null
            ? List<ContactUsData>.from(
                json["data"].map((x) => ContactUsData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ContactUsData extends ContactUsEntity {
  ContactUsData({
    this.code,
    this.description,
    this.value,
    this.status,
  });

  String code;
  String description;
  String value;
  String status;

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
        code: json["code"],
        description: json["description"],
        value: json["value"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "value": value,
        "status": status,
      };
}
