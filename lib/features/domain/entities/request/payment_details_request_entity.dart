import 'package:ceylife_digital/features/data/models/requests/payment_details_request.dart';

class PaymentDetailsRequestEntity extends PaymentDetailsRequest {
  PaymentDetailsRequestEntity({
    this.policyNo,
    this.clientNo,
    this.pageNo
  }) : super(clientNo: clientNo, policyNo: policyNo, pageNo: pageNo);

  String policyNo;
  String clientNo;
  int pageNo;
}
