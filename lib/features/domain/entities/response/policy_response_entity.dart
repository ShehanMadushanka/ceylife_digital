// To parse this JSON data, do
//
//     final policyResponseEntity = policyResponseEntityFromJson(jsonString);

import 'package:equatable/equatable.dart';

class PolicyResponseEntity extends Equatable{


  PolicyResponseEntity({
    this.email, this.responseError, this.responseCode, this.mobileNo, this.otpRef, this.userType
  });

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;

  @override
  List<Object> get props => [email, mobileNo, otpRef];
}
