import 'package:equatable/equatable.dart';

class ResendOtpResponseEntity extends Equatable {
  ResendOtpResponseEntity(
      {this.responseError,
      this.responseCode,
      this.email,
      this.mobileNo,
      this.otpRef,
      this.userType,
      this.nickName});

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;
  String nickName;

  @override
  List<Object> get props => [email, mobileNo, otpRef, userType, nickName];
}
