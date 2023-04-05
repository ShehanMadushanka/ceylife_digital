// To parse this JSON data, do
//
//     final generatePaymentLinkRequest = generatePaymentLinkRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GeneratePaymentLinkRequest extends Equatable {
  GeneratePaymentLinkRequest({
    this.amount,
    this.endDate,
    this.interval,
    this.mobileNo,
    this.mobileUserId,
    this.paymentType,
    this.policyNo,
    this.premium,
    this.refCode,
    this.startDate,
  });

  double amount;
  String endDate;
  String interval;
  String mobileNo;
  int mobileUserId;
  int paymentType;
  String policyNo;
  int premium;
  String refCode;
  String startDate;

  factory GeneratePaymentLinkRequest.fromRawJson(String str) =>
      GeneratePaymentLinkRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneratePaymentLinkRequest.fromJson(Map<String, dynamic> json) =>
      GeneratePaymentLinkRequest(
        amount: json["amount"],
        endDate: json["endDate"],
        interval: json["interval"],
        mobileNo: json["mobileNo"],
        mobileUserId: json["mobileUserId"],
        paymentType: json["paymentType"],
        policyNo: json["policyNo"],
        premium: json["premium"],
        refCode: json["refCode"],
        startDate: json["startDate"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "endDate": endDate,
        "interval": interval,
        "mobileNo": mobileNo,
        "mobileUserId": mobileUserId,
        "paymentType": paymentType,
        "policyNo": policyNo,
        "premium": premium,
        "refCode": refCode,
        "startDate": startDate,
      };

  @override
  List<Object> get props => [amount, endDate, interval];
}
