import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterLeadGeneratorRequest extends Equatable {
  RegisterLeadGeneratorRequest(
      {this.leadGeneratorId,
      this.nic,
      this.userName,
      this.nickName,
      this.password,
      this.branchId,
      this.accountHolderName,
      this.accountNo,
      this.addressCity,
      this.addressLine1,
      this.addressLine2,
      this.bankBranchId,
      this.bankCode,
      this.contactNo,
      this.contactNo2,
      this.email,
      this.fullName});

  int leadGeneratorId;
  String nic;
  String userName;
  String nickName;
  String password;
  int branchId;
  String accountHolderName;
  String accountNo;
  String addressCity;
  String addressLine1;
  String addressLine2;
  int bankBranchId;
  String bankCode;
  String contactNo;
  String contactNo2;
  String email;
  String fullName;

  factory RegisterLeadGeneratorRequest.fromRawJson(String str) =>
      RegisterLeadGeneratorRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterLeadGeneratorRequest.fromJson(Map<String, dynamic> json) =>
      RegisterLeadGeneratorRequest(
        leadGeneratorId: json["leadGeneratorId"],
        nic: json["nic"],
        userName: json["username"],
        nickName: json["nickName"],
        password: json["password"],
        branchId: json["branchId"],
        accountHolderName: json["accountHolderName"],
        accountNo: json["accountNo"],
        addressCity: json["addressCity"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        bankBranchId: json["bankBranchId"],
        bankCode: json["branchCode"],
        contactNo: json["contactNo"],
        contactNo2: json["contactNo2"],
        email: json["email"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "leadGeneratorId": leadGeneratorId,
        "nic": nic,
        "username": userName,
        "nickName": nickName,
        "password": password,
        "branchId": branchId,
        "accountHolderName": accountHolderName,
        "accountNo": accountNo,
        "addressCity": addressCity,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "bankBranchId": bankBranchId,
        "branchCode": bankCode,
        "contactNo": contactNo,
        "contactNo2": contactNo2,
        "email": email,
        "fullName": fullName,
      };

  @override
  List<Object> get props => [
        leadGeneratorId,
        nic,
        userName,
        nickName,
        password,
        branchId,
        accountHolderName,
        accountNo,
        addressCity,
        addressLine1,
        addressLine2,
        bankBranchId,
        bankCode,
        contactNo,
        contactNo2,
        email,
        fullName
      ];
}
