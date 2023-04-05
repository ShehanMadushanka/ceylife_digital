// To parse this JSON data, do
//
//     final getNewsResponse = getNewsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';

class GetNewsResponse extends GetNewsResponseEntity {
  GetNewsResponse({
    this.responseCode,
    this.responseError,
    this.data,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            newsData: data);

  String responseCode;
  String responseError;
  List<NewsData> data;

  factory GetNewsResponse.fromRawJson(String str) =>
      GetNewsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetNewsResponse.fromJson(Map<String, dynamic> json) =>
      GetNewsResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["data"] != null
            ? List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsData extends CeylifeNewsEntity {
  NewsData(
      {this.newsUpdateDetailsId,
      this.newsUpdateTitle,
      this.content,
      this.startDate,
      this.endDate,
      this.thumbnailImagePath,
      this.imagePath,
      this.status,
      this.lastUpdatedTime,
      this.createdTime})
      : super(
            dateTime: endDate,
            image: imagePath,
            newsDescription: content,
            newsTitle: newsUpdateTitle,
            newsUpdateDetailsId: newsUpdateDetailsId,
            createdTime: createdTime,
            thumbnail: thumbnailImagePath);

  int newsUpdateDetailsId;
  String newsUpdateTitle;
  String content;
  String startDate;
  String endDate;
  dynamic thumbnailImagePath;
  dynamic imagePath;
  String status;
  String lastUpdatedTime;
  String createdTime;

  factory NewsData.fromRawJson(String str) =>
      NewsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        newsUpdateDetailsId: json["newsUpdateDetailsId"],
        newsUpdateTitle: json["newsUpdateTitle"],
        content: json["content"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        thumbnailImagePath: json["thumbnailImagePath"],
        imagePath: json["imagePath"],
        status: json["status"],
        lastUpdatedTime: json["lastUpdatedTime"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "newsUpdateDetailsId": newsUpdateDetailsId,
        "newsUpdateTitle": newsUpdateTitle,
        "content": content,
        "startDate": startDate,
        "endDate": endDate,
        "thumbnailImagePath": thumbnailImagePath,
        "imagePath": imagePath,
        "status": status,
        "lastUpdatedTime": lastUpdatedTime,
        "createdTime": createdTime,
      };
}
