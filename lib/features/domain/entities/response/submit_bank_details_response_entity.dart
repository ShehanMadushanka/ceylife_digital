import 'package:equatable/equatable.dart';

class SubmitBankDetailsResponseEntity extends Equatable {
  SubmitBankDetailsResponseEntity({
    this.email,
    this.mobileNo,
    this.otpRef,
    this.responseCode,
    this.responseError,
  });

  String email;
  String mobileNo;
  String otpRef;
  String responseCode;
  String responseError;

  @override
  List<Object> get props =>
      [responseCode, responseError, email, mobileNo, otpRef];
}
