import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/get_bank_branches_response_entity.dart';

class GetBankBranchesResponse extends GetBankBranchesResponseEntity {
  GetBankBranchesResponse({
    this.data,
    this.responseCode,
    this.responseError,
  }) : super(
            getBankBranches: data,
            responseCode: responseCode,
            responseError: responseError);

  List<BankBranchData> data;
  String responseCode;
  String responseError;

  factory GetBankBranchesResponse.fromRawJson(String str) =>
      GetBankBranchesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBankBranchesResponse.fromJson(Map<String, dynamic> json) =>
      GetBankBranchesResponse(
        data: json["branches"] != null
            ? List<BankBranchData>.from(
                json["branches"].map((x) => BankBranchData.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "branches": List<dynamic>.from(data.map((x) => x.toJson())),
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class BankBranchData extends GetBankBranchesEntity {
  BankBranchData(
      {this.bankBranchId,
      this.bankCode,
      this.branchName,
      this.branchCode,
      this.status,
      this.createdTime,
      this.lastUpdatedTime})
      : super(
            bankBranchId: bankBranchId,
            bankCode: branchCode,
            branchName: branchName,
            branchCode: branchCode,
            status: status,
            createdTime: createdTime,
            lastUpdatedTime: lastUpdatedTime);

  int bankBranchId;
  String bankCode;
  String branchCode;
  String branchName;
  String createdTime;
  String lastUpdatedTime;
  String status;

  factory BankBranchData.fromRawJson(String str) =>
      BankBranchData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankBranchData.fromJson(Map<String, dynamic> json) => BankBranchData(
        bankBranchId: json["bankBranchId"],
        bankCode: json["bankCode"],
        branchCode: json["branchCode"],
        branchName: json["branchName"],
        createdTime: json["createdTime"],
        lastUpdatedTime: json["lastUpdatedTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bankBranchId": bankBranchId,
        "bankCode": branchCode,
        "branchCode": branchCode,
        "branchName": branchName,
        "createdTime": createdTime,
        "lastUpdatedTime": lastUpdatedTime,
        "status": status
      };
}
