// To parse this JSON data, do
//
//     final generatePaymentLinkResponse = generatePaymentLinkResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';

class GeneratePaymentLinkResponse extends GeneratePaymentLinkResponseEntity {
  GeneratePaymentLinkResponse({
    this.dataObj,
    this.paymentGatewayUrl,
    this.refCode,
    this.responseCode,
    this.responseError,
  }) : super(
            refCode: refCode,
            responseError: responseError,
            responseCode: responseCode,
            data: dataObj,
            paymentGatewayUrl: paymentGatewayUrl);

  List<PaymentURLData> dataObj;
  String paymentGatewayUrl;
  String refCode;
  String responseCode;
  String responseError;

  factory GeneratePaymentLinkResponse.fromRawJson(String str) =>
      GeneratePaymentLinkResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneratePaymentLinkResponse.fromJson(Map<String, dynamic> json) =>
      GeneratePaymentLinkResponse(
        dataObj: json["data"] != null
            ? List<PaymentURLData>.from(
                json["data"].map((x) => PaymentURLData.fromJson(x)))
            : List.empty(),
        paymentGatewayUrl: json["paymentGatewayUrl"],
        refCode: json["refCode"],
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(dataObj.map((x) => x.toJson())),
        "paymentGatewayUrl": paymentGatewayUrl,
        "refCode": refCode,
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class PaymentURLData extends PaymentURLDataEntity {
  PaymentURLData({
    this.amount,
    this.policyNo,
    this.receiptDate,
  }) : super(amount: amount, policyNo: policyNo, receiptDate: receiptDate);

  int amount;
  String policyNo;
  String receiptDate;

  factory PaymentURLData.fromRawJson(String str) =>
      PaymentURLData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentURLData.fromJson(Map<String, dynamic> json) => PaymentURLData(
        amount: json["amount"],
        policyNo: json["policyNo"],
        receiptDate: json["receiptDate"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "policyNo": policyNo,
        "receiptDate": receiptDate,
      };
}
