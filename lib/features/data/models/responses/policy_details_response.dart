// To parse this JSON data, do
//
//     final policyDetailsResponse = policyDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/utils/string_util.dart';

class PolicyDetailsResponse extends PolicyDetailsResponseEntity {
  PolicyDetailsResponse({
    this.dataObj,
    this.responseCode,
    this.responseError,
  }) : super(
            data: dataObj,
            responseCode: responseCode,
            responseError: responseError);

  List<PolicyDetailIItem> dataObj;
  String responseCode;
  String responseError;

  factory PolicyDetailsResponse.fromRawJson(String str) =>
      PolicyDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PolicyDetailsResponse(
        dataObj: json["policyDetails"] != null
            ? List<PolicyDetailIItem>.from(
                json["policyDetails"].map((x) => PolicyDetailIItem.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "policyDetails": List<dynamic>.from(dataObj.map((x) => x.toJson())),
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class PolicyDetailIItem extends PolicyDetailItemEntity {
  PolicyDetailIItem({
    this.accountBalance,
    this.branch,
    this.clientNo,
    this.interest,
    this.name,
    this.paidUpDate,
    this.paymentMode,
    this.planName,
    this.policyNo,
    this.policyStatus,
    this.premium,
    this.premiumCessDate,
    this.premiumDue,
    this.riskDate,
    this.sumAssured,
    this.sundryBalance,
    this.term,
    this.totalDue,
  }) : super(
            policyNo: policyNo,
            clientNo: clientNo,
            accountBalance: accountBalance,
            branch: branch,
            interest: interest,
            name: name,
            paidUpDate: paidUpDate,
            paymentMode: paymentMode,
            planName: planName,
            policyStatus: policyStatus,
            premium: premium,
            premiumCessDate: premiumCessDate,
            premiumDue: premiumDue,
            riskDate: riskDate,
            sumAssured: sumAssured,
            sundryBalance: sundryBalance,
            term: term,
            totalDue: totalDue,
            policyStatusEnum: StringUtils.mapPolicyStatusEnum(policyStatus));

  double accountBalance;
  String branch;
  String clientNo;
  double interest;
  String name;
  String paidUpDate;
  String paymentMode;
  String planName;
  String policyNo;
  String policyStatus;
  double premium;
  String premiumCessDate;
  double premiumDue;
  String riskDate;
  double sumAssured;
  double sundryBalance;
  double term;
  double totalDue;

  factory PolicyDetailIItem.fromRawJson(String str) =>
      PolicyDetailIItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyDetailIItem.fromJson(Map<String, dynamic> json) =>
      PolicyDetailIItem(
        accountBalance: json["accountBalance"],
        branch: json["branch"],
        clientNo: json["clientNo"],
        interest: json["interest"],
        name: json["name"],
        paidUpDate: json["paidUpDate"],
        paymentMode: json["paymentMode"],
        planName: json["planName"],
        policyNo: json["policyNo"],
        policyStatus: json["policyStatus"],
        premium: json["premium"],
        premiumCessDate: json["premiumCessDate"],
        premiumDue: json["premiumDue"],
        riskDate: json["riskDate"],
        sumAssured: json["sumAssured"],
        sundryBalance: json["sundryBalance"],
        term: json["term"],
        totalDue: json["totalDue"],
      );

  Map<String, dynamic> toJson() => {
        "accountBalance": accountBalance,
        "branch": branch,
        "clientNo": clientNo,
        "interest": interest,
        "name": name,
        "paidUpDate": paidUpDate,
        "paymentMode": paymentMode,
        "planName": planName,
        "policyNo": policyNo,
        "policyStatus": policyStatus,
        "premium": premium,
        "premiumCessDate": premiumCessDate,
        "premiumDue": premiumDue,
        "riskDate": riskDate,
        "sumAssured": sumAssured,
        "sundryBalance": sundryBalance,
        "term": term,
        "totalDue": totalDue,
      };
}
