// To parse this JSON data, do
//
//     final getPromotionsResponse = getPromotionsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';

class GetPromotionsResponse extends PromotionResponseEntity {
  GetPromotionsResponse({
    this.responseCode,
    this.responseError,
    this.data,
  }) : super(
            promotions: data,
            responseCode: responseCode,
            responseError: responseError);

  String responseCode;
  String responseError;
  List<PromotionData> data;

  factory GetPromotionsResponse.fromRawJson(String str) =>
      GetPromotionsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPromotionsResponse.fromJson(Map<String, dynamic> json) =>
      GetPromotionsResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["data"] != null
            ? List<PromotionData>.from(
                json["data"].map((x) => PromotionData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PromotionData extends PromotionsEntity {
  PromotionData(
      {this.promoDetailId,
      this.promotionType,
      this.promoTitle,
      this.content,
      this.startDate,
      this.endDate,
      this.imagePath,
      this.thumbnailImagePath,
      this.status,
      this.conditions,
      this.contactNo,
      this.link,
      this.lastUpdateTime,
      this.endTime,
      this.createdTime})
      : super(
            title: promoTitle,
            description: content,
            imageURL: imagePath,
            validDate: endDate,
            validTime: endTime,
            contactNumber: contactNo,
            link: link,
            createdTime: createdTime);

  int promoDetailId;
  int promotionType;
  String promoTitle;
  String content;
  String startDate;
  String endDate;
  String endTime;
  String imagePath;
  String thumbnailImagePath;
  String status;
  String conditions;
  String contactNo;
  String link;
  String lastUpdateTime;
  String createdTime;

  factory PromotionData.fromRawJson(String str) =>
      PromotionData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PromotionData.fromJson(Map<String, dynamic> json) => PromotionData(
      promoDetailId: json["promoDetailId"],
      promotionType: json["promotionType"],
      promoTitle: json["promoTitle"],
      content: json["content"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      endTime: json["endTime"],
      imagePath: json["imagePath"],
      thumbnailImagePath: json["thumbnailImagePath"],
      status: json["status"],
      conditions: json["conditions"],
      contactNo: json["contactNo"],
      link: json["link"],
      lastUpdateTime: json["lastUpdateTime"],
      createdTime: json["createdTime"]);

  Map<String, dynamic> toJson() => {
        "promoDetailId": promoDetailId,
        "promotionType": promotionType,
        "promoTitle": promoTitle,
        "content": content,
        "startDate": startDate,
        "endDate": endDate,
        "endTime": endTime,
        "imagePath": imagePath,
        "thumbnailImagePath": thumbnailImagePath,
        "status": status,
        "conditions": conditions,
        "contactNo": contactNo,
        "link": link,
        "lastUpdateTime": lastUpdateTime,
        "createdTime": createdTime,
      };
}
