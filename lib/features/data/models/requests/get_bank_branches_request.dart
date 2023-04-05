

import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetBankBranchesRequest extends Equatable {
  GetBankBranchesRequest({
    this.bankCode,
  });

  String bankCode;

  factory GetBankBranchesRequest.fromRawJson(String str) =>
      GetBankBranchesRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBankBranchesRequest.fromJson(Map<String, dynamic> json) =>
      GetBankBranchesRequest(
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
    "bankCode": bankCode,
  };

  @override
  List<Object> get props => [bankCode];
}
