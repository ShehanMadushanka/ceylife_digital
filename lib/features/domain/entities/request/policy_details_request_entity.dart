import 'package:ceylife_digital/features/data/models/requests/policy_details_request.dart';

class PolicyDetailsRequestEntity extends PolicyDetailsRequest {
  PolicyDetailsRequestEntity({
    this.policyNo,
    this.clientNo,
  }) : super(clientNo: clientNo, policyNo: policyNo);

  String policyNo;
  String clientNo;
}
