import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubmitBankDetailsRequest extends Equatable {
  SubmitBankDetailsRequest(
      {this.accountHolderName,
      this.accountNo,
      this.bankCode,
      this.bankBranchId,
      this.leadGeneratorId});

  String accountHolderName;
  String accountNo;
  String bankCode;
  int bankBranchId;
  int leadGeneratorId;

  factory SubmitBankDetailsRequest.fromRawJson(String str) =>
      SubmitBankDetailsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitBankDetailsRequest.fromJson(Map<String, dynamic> json) =>
      SubmitBankDetailsRequest(
        accountHolderName: json["accountHolderName"],
        accountNo: json["accountNo"],
        bankCode: json["bankCode"],
        bankBranchId: json["bankBranchId"],
        leadGeneratorId: json["leadGeneratorId"],
      );

  Map<String, dynamic> toJson() => {
        "accountHolderName": accountHolderName,
        "accountNo": accountNo,
        "bankCode": bankCode,
        "bankBranchId": bankBranchId,
        "leadGeneratorId": leadGeneratorId,
      };

  @override
  List<Object> get props =>
      [accountHolderName, accountNo, bankCode, bankBranchId, leadGeneratorId];
}
