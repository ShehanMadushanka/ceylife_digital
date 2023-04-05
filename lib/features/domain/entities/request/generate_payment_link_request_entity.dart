// To parse this JSON data, do
//
//     final generatePaymentLinkRequest = generatePaymentLinkRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/generate_payment_link_request.dart';

class GeneratePaymentLinkRequestEntity extends GeneratePaymentLinkRequest {
  GeneratePaymentLinkRequestEntity({
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
  }) : super(
            mobileUserId: mobileUserId,
            policyNo: policyNo,
            amount: amount,
            premium: premium,
            mobileNo: mobileNo,
            endDate: endDate,
            interval: interval,
            paymentType: paymentType,
            refCode: refCode,
            startDate: startDate);

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
}
