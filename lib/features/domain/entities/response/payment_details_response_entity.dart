// To parse this JSON data, do
//
//     final paymentDetailsResponse = paymentDetailsResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class PaymentDetailsResponseEntity extends Equatable {
  PaymentDetailsResponseEntity({
    this.data,
    this.responseCode,
    this.responseError,
  });

  List<PaymentHistoryItemEntity> data;
  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseCode, responseError, data];
}

class PaymentHistoryItemEntity extends Equatable {
  PaymentHistoryItemEntity({
    this.amount,
    this.policyNo,
    this.receiptDate,
    this.receiptNo,
  });

  double amount;
  String policyNo;
  String receiptDate;
  String receiptNo;

  @override
  List<Object> get props => [amount, policyNo, receiptNo, receiptDate];
}
