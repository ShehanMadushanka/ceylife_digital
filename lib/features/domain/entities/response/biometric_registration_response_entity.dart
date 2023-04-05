// To parse this JSON data, do
//
//     final biometricRegistrationResponse = biometricRegistrationResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class BiometricRegistrationResponseEntity extends Equatable {
  BiometricRegistrationResponseEntity({
    this.responseCode,
    this.responseError,
  });

  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
