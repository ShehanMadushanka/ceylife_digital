// To parse this JSON data, do
//
//     final otpResponseEntity = otpResponseEntityFromJson(jsonString);

class OtpResponseEntity {
  OtpResponseEntity({
    this.userType,
    this.nic,
    this.nickName,
    this.otpRef,
    this.userOtp,
    this.responseError,
    this.responseCode,
  });

  int userType;
  String nic;
  String nickName;
  String otpRef;
  String userOtp;
  String responseCode;
  String responseError;
}
