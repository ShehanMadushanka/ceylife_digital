// To parse this JSON data, do
//
//     final createUserRequest = createUserRequestFromJson(jsonString);

import 'package:ceylife_digital/features/data/models/requests/create_user_request.dart';

class CreateUserRequestEntity extends CreateUserRequest {
  CreateUserRequestEntity(
      {this.email,
      this.nic,
      this.nickname,
      this.password,
      this.username,
      this.pushId,
      this.mobileOs,
      this.mobileModel,
      this.mobileManufacture,
      this.mobileIMEINo,
      this.deviceId})
      : super(
            nic: nic,
            email: email,
            password: password,
            username: username,
            nickname: nickname,
            deviceId: deviceId,
            mobileIMEINo: mobileIMEINo,
            mobileManufacture: mobileManufacture,
            mobileModel: mobileModel,
            mobileOs: mobileOs,
            pushId: pushId);

  String email;
  String nic;
  String nickname;
  String password;
  String username;
  String deviceId;
  String pushId;
  String mobileIMEINo;
  String mobileOs;
  String mobileManufacture;
  String mobileModel;
}
