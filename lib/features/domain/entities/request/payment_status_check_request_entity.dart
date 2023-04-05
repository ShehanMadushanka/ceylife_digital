// To parse this JSON data, do
//
//     final paymentStatusCheckRequest = paymentStatusCheckRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/payment_status_check_request.dart';

class PaymentStatusCheckRequestEntity extends PaymentStatusCheckRequest {
  PaymentStatusCheckRequestEntity({
    this.refCode,
  }) : super(refCode: refCode);

  String refCode;
}
