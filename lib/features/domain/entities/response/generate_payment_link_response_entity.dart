// To parse this JSON data, do
//
//     final generatePaymentLinkResponse = generatePaymentLinkResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class GeneratePaymentLinkResponseEntity extends Equatable {
  GeneratePaymentLinkResponseEntity({
    this.data,
    this.paymentGatewayUrl,
    this.refCode,
    this.responseCode,
    this.responseError,
    this.paymentAmount
  });

  List<PaymentURLDataEntity> data;
  String paymentGatewayUrl;
  String refCode;
  String responseCode;
  String responseError;
  double paymentAmount;

  @override
  List<Object> get props => [data, paymentGatewayUrl, refCode];
}

class PaymentURLDataEntity extends Equatable {
  PaymentURLDataEntity({
    this.amount,
    this.policyNo,
    this.receiptDate,
  });

  int amount;
  String policyNo;
  String receiptDate;

  @override
  List<Object> get props => [amount, policyNo, receiptDate];
}
