// To parse this JSON data, do
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdatePasswordRequest extends Equatable{
  UpdatePasswordRequest({
    this.username,
    this.password,
  });

  String username;
  String password;

  factory UpdatePasswordRequest.fromRawJson(String str) => UpdatePasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) => UpdatePasswordRequest(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };

  @override
  List<Object> get props => [username, password];
}
