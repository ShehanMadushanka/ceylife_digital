import 'dart:convert';

class User {
  User({
    this.username,
    this.nic,
  });

  String username;
  String nic;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    nic: json["nic"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "nic": nic,
  };
}
