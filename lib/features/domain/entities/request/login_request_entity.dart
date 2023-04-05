// To parse this JSON data, do
//
//     final getLoginRequest = getLoginRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/get_login_request.dart';

class LoginRequestEntity extends GetLoginRequest {
  LoginRequestEntity(
      {this.deviceId,
      this.mobileImeiNo,
      this.mobileManufacture,
      this.mobileModel,
      this.mobileOs,
      this.password,
      this.pushId,
      this.username,
      this.signInMode})
      : super(
            password: password,
            deviceId: deviceId,
            username: username,
            mobileImeiNo: mobileImeiNo,
            mobileManufacture: mobileManufacture,
            mobileModel: mobileModel,
            mobileOs: mobileOs,
            pushId: pushId,
            signInMode: signInMode);

  String deviceId;
  String mobileImeiNo;
  String mobileManufacture;
  String mobileModel;
  String mobileOs;
  String password;
  String pushId;
  String username;
  String signInMode;
}
