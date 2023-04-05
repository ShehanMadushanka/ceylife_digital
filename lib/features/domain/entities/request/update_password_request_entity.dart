// To parse this JSON data, do

import 'package:ceylife_digital/features/data/models/requests/update_password_request.dart';

class UpdatePasswordRequestEntity extends UpdatePasswordRequest {
  UpdatePasswordRequestEntity({
    this.username,
    this.password,
  }) : super(username: username, password: password);

  String username;
  String password;
}
