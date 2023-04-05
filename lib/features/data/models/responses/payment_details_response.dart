// To parse this JSON data, do
//
//     final paymentDetailsResponse = paymentDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';

class PaymentDetailsResponse extends PaymentDetailsResponseEntity {
  PaymentDetailsResponse({
    this.dataObj,
    this.responseCode,
    this.responseError,
  }) : super(
            responseError: responseError,
            responseCode: responseCode,
            data: dataObj);

  List<PaymentHistoryItem> dataObj;
  String responseCode;
  String responseError;

  factory PaymentDetailsResponse.fromRawJson(String str) =>
      PaymentDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsResponse(
        dataObj: json["data"] != null
            ? List<PaymentHistoryItem>.from(
                json["data"].map((x) => PaymentHistoryItem.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataObj.map((x) => x.toJson())),
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class PaymentHistoryItem extends PaymentHistoryItemEntity {
  PaymentHistoryItem({
    this.amount,
    this.policyNo,
    this.receiptDate,
    this.receiptNo,
  }) : super(
            policyNo: policyNo,
            amount: amount,
            receiptDate: receiptDate,
            receiptNo: receiptNo);

  double amount;
  String policyNo;
  String receiptDate;
  String receiptNo;

  factory PaymentHistoryItem.fromRawJson(String str) =>
      PaymentHistoryItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryItem(
        amount: json["amount"].toDouble(),
        policyNo: json["policyNo"],
        receiptDate: json["receiptDate"],
        receiptNo: json["receiptNo"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "policyNo": policyNo,
        "receiptDate": receiptDate,
        "receiptNo": receiptNo,
      };
}
