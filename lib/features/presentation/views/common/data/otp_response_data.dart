import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';

class OTPResponseData {
  bool isVerificationSuccess;
  OtpResponseEntity payload;

  OTPResponseData({this.isVerificationSuccess = false, this.payload});
}
