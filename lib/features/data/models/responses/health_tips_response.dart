// To parse this JSON data, do
//
//     final healthTipsResponse = healthTipsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';

class HealthTipsResponse extends HealthTipsResponseEntity {
  HealthTipsResponse({
    this.ageRangesObj,
    this.healthTipsObj,
    this.responseCode,
    this.responseError,
    this.userAgeRange
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            ageRanges: ageRangesObj,
            healthTips: healthTipsObj);

  List<AgeRange> ageRangesObj;
  List<HealthTip> healthTipsObj;
  String responseCode;
  String responseError;
  int userAgeRange;

  factory HealthTipsResponse.fromRawJson(String str) =>
      HealthTipsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HealthTipsResponse.fromJson(Map<String, dynamic> json) =>
      HealthTipsResponse(
        ageRangesObj: json["ageRanges"] != null
            ? List<AgeRange>.from(
                json["ageRanges"].map((x) => AgeRange.fromJson(x)))
            : List.empty(),
        healthTipsObj: json["healthTips"] != null
            ? List<HealthTip>.from(
                json["healthTips"].map((x) => HealthTip.fromJson(x)))
            : List.empty(),
        userAgeRange: json["userAgeRange"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "ageRanges": List<dynamic>.from(ageRangesObj.map((x) => x.toJson())),
        "healthTips": List<dynamic>.from(healthTipsObj.map((x) => x.toJson())),
        "userAgeRange": userAgeRange,
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class AgeRange extends AgeRangeEntity {
  AgeRange({
    this.ageFrom,
    this.ageTo,
    this.healthAgeRangeId,
    this.status,
  }) : super(
            status: status,
            ageFrom: ageFrom,
            ageTo: ageTo,
            healthAgeRangeId: healthAgeRangeId);

  int ageFrom;
  int ageTo;
  int healthAgeRangeId;
  String status;

  factory AgeRange.fromRawJson(String str) =>
      AgeRange.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgeRange.fromJson(Map<String, dynamic> json) => AgeRange(
        ageFrom: json["ageFrom"],
        ageTo: json["ageTo"],
        healthAgeRangeId: json["healthAgeRangeId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ageFrom": ageFrom,
        "ageTo": ageTo,
        "healthAgeRangeId": healthAgeRangeId,
        "status": status,
      };
}

class HealthTip extends HealthTipEntity {
  HealthTip({
    this.ageRangeIds,
    this.content,
    this.createdTime,
    this.healthTipId,
    this.imageUrl,
    this.lastUpdatedTime,
    this.status,
    this.thumbnailImagePath,
    this.title,
  }) : super(
            status: status,
            title: title,
            ageRangeIds: ageRangeIds,
            content: content,
            createdTime: createdTime,
            healthTipId: healthTipId,
            imageUrl: imageUrl,
            lastUpdatedTime: lastUpdatedTime,
            thumbnailImagePath: thumbnailImagePath);

  List<int> ageRangeIds;
  String content;
  String createdTime;
  int healthTipId;
  String imageUrl;
  String lastUpdatedTime;
  String status;
  String thumbnailImagePath;
  String title;

  factory HealthTip.fromRawJson(String str) =>
      HealthTip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HealthTip.fromJson(Map<String, dynamic> json) => HealthTip(
        ageRangeIds: json["ageRangeIds"] != null
            ? List<int>.from(json["ageRangeIds"].map((x) => x))
            : List.empty(),
        content: json["content"],
        createdTime: json["createdTime"],
        healthTipId: json["healthTipId"],
        imageUrl: json["imageUrl"],
        lastUpdatedTime: json["lastUpdatedTime"],
        status: json["status"],
        thumbnailImagePath: json["thumbnailImagePath"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "ageRangeIds": List<dynamic>.from(ageRangeIds.map((x) => x)),
        "content": content,
        "createdTime": createdTime,
        "healthTipId": healthTipId,
        "imageUrl": imageUrl,
        "lastUpdatedTime": lastUpdatedTime,
        "status": status,
        "thumbnailImagePath": thumbnailImagePath,
        "title": title,
      };
}
