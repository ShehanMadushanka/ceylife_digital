// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/get_policy_request.dart';

class PolicyRequestEntity extends GetPolicyRequest {
  PolicyRequestEntity({this.key, this.keyType, this.registrationType})
      : super(key: key, keyType: keyType, registrationType: registrationType);

  final String key;
  final int keyType;
  final int registrationType;
}
