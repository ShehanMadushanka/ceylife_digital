import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdatePasswordResponseEntity extends Equatable{
  UpdatePasswordResponseEntity({
    this.email,
    this.mobileNo,
    this.nickName,
    this.otpRef,
    this.responseCode,
    this.responseError,
    this.userType,
  });

  String email;
  String mobileNo;
  String nickName;
  String otpRef;
  String responseCode;
  String responseError;
  int userType;

  @override
  List<Object> get props => [responseCode, responseError, email, mobileNo];
}
