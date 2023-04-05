// To parse this JSON data, do
//
//     final getFaqResponse = getFaqResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';

class GetFaqResponse extends FAQResponseEntity {
  GetFaqResponse({
    this.responseCode,
    this.responseError,
    this.data,
  }) : super(
            faqData: data,
            responseError: responseError,
            responseCode: responseCode);

  String responseCode;
  String responseError;
  List<FAQData> data;

  factory GetFaqResponse.fromRawJson(String str) =>
      GetFaqResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFaqResponse.fromJson(Map<String, dynamic> json) => GetFaqResponse(
        responseCode: json["response_code"],
        responseError: json["response_error"],
        data: json["data"] != null
            ? List<FAQData>.from(json["data"].map((x) => FAQData.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FAQData extends FAQ {
  FAQData(
      {this.faqId,
      this.referenceTypeId,
      this.question,
      this.answer,
      this.reference,
      this.createdDateTime,
      this.lastUpdatedDateTime,
      this.sortedKey})
      : super(question, answer, reference, referenceTypeId, sortedKey);

  int faqId;
  int sortedKey;
  int referenceTypeId;
  String question;
  String answer;
  String reference;
  String createdDateTime;
  String lastUpdatedDateTime;

  factory FAQData.fromRawJson(String str) => FAQData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQData.fromJson(Map<String, dynamic> json) => FAQData(
        faqId: json["faqId"],
        referenceTypeId: json["referenceTypeId"],
        question: json["question"],
        answer: json["answer"],
        sortedKey: json["sortedKey"],
        reference: json["reference"],
        createdDateTime: json["createdDateTime"],
        lastUpdatedDateTime: json["lastUpdatedDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "faqId": faqId,
        "referenceTypeId": referenceTypeId,
        "question": question,
        "answer": answer,
        "sortedKey": sortedKey,
        "reference": reference,
        "createdDateTime": createdDateTime,
        "lastUpdatedDateTime": lastUpdatedDateTime,
      };
}
