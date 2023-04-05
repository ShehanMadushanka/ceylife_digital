import 'package:equatable/equatable.dart';

class CreateUserResponseEntity extends Equatable {
  CreateUserResponseEntity({
    this.responseCode,
    this.responseError,
    this.email,
    this.mobileNo,
    this.otpRef,
    this.userType,
  });

  String responseCode;
  String responseError;
  String email;
  String mobileNo;
  String otpRef;
  int userType;

  @override
  List<Object> get props => [responseError, responseCode];
}
