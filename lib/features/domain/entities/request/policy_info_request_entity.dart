import 'package:ceylife_digital/features/data/models/requests/policy_info_request.dart';

class PolicyInfoRequestEntity extends PolicyInfoRequest {
  PolicyInfoRequestEntity({
    this.policyNo,
  }) : super(policyNo: policyNo);

  String policyNo;
}
