

import 'package:equatable/equatable.dart';

class VerifyNewLeadGeneratoResponseEntity extends Equatable{
  VerifyNewLeadGeneratoResponseEntity({
    this.email,
    this.leadGeneratorId,
    this.mobileNo,
    this.otpRef,
    this.responseCode,
    this.responseError,
  });

  String email;
  int leadGeneratorId;
  String mobileNo;
  String otpRef;
  String responseCode;
  String responseError;
  @override
  List<Object> get props => [email,leadGeneratorId,mobileNo,otpRef,responseError, responseCode];


}
