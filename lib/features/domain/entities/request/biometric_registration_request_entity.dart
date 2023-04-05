// To parse this JSON data, do
//
//     final biometricRegistrationRequest = biometricRegistrationRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/biometric_registration_request.dart';

class BiometricRegistrationRequestEntity extends BiometricRegistrationRequest {
  BiometricRegistrationRequestEntity({
    this.mobileUserId,
    this.bioAuthEnable,
  }) : super(bioAuthEnable: bioAuthEnable, mobileUserId: mobileUserId);

  int mobileUserId;
  int bioAuthEnable;
}
