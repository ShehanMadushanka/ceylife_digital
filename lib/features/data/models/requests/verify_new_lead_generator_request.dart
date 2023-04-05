import 'dart:convert';

import 'package:equatable/equatable.dart';

class VerifyNewLeadGeneratorRequest extends Equatable {
  VerifyNewLeadGeneratorRequest(
      {this.nic,
      this.email,
      this.contactNo,
      this.contactNo2,
    });

  String nic;
  String email;
  String contactNo;
  String contactNo2;

  factory VerifyNewLeadGeneratorRequest.fromRawJson(String str) =>
      VerifyNewLeadGeneratorRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyNewLeadGeneratorRequest.fromJson(Map<String, dynamic> json) =>
      VerifyNewLeadGeneratorRequest(
        nic: json["nic"],
        email: json["email"],
        contactNo: json["contactNo"],
        contactNo2: json["contactNo2"],
      );

  Map<String, dynamic> toJson() => {
        "nic": nic,
        "email": email,
        "contactNo": contactNo,
        "contactNo2": contactNo2,

      };

  @override
  List<Object> get props => [
        nic,
        contactNo,
        contactNo2,
      ];
}
