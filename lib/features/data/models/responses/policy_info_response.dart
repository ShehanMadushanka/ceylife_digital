// To parse this JSON data, do
//
//     final policyInfoResponse = policyInfoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';

class PolicyInfoResponse extends PolicyInfoResponseEntity {
  PolicyInfoResponse({
    this.benefitsObj,
    this.policyLoansObj,
    this.responseCode,
    this.responseError,
  }) : super(
            responseCode: responseCode,
            responseError: responseError,
            benefits: benefitsObj,
            policyLoans: policyLoansObj);

  List<Benefit> benefitsObj;
  List<PolicyLoan> policyLoansObj;
  String responseCode;
  String responseError;

  factory PolicyInfoResponse.fromRawJson(String str) =>
      PolicyInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyInfoResponse.fromJson(Map<String, dynamic> json) =>
      PolicyInfoResponse(
        benefitsObj: json["benefits"] != null
            ? List<Benefit>.from(
                json["benefits"].map((x) => Benefit.fromJson(x)))
            : List.empty(),
        policyLoansObj: json["policyLoans"] != null
            ? List<PolicyLoan>.from(
                json["policyLoans"].map((x) => PolicyLoan.fromJson(x)))
            : List.empty(),
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "benefits": List<dynamic>.from(benefitsObj.map((x) => x.toJson())),
        "policyLoans":
            List<dynamic>.from(policyLoansObj.map((x) => x.toJson())),
        "response_code": responseCode,
        "response_error": responseError,
      };
}

class Benefit extends BenefitEntity {
  Benefit({
    this.benefitMasterObj,
    this.coverAmount,
    this.lifeno,
    this.policyNo,
  }) : super(
            policyNo: policyNo,
            benefitMaster: benefitMasterObj,
            coverAmount: coverAmount,
            lifeno: lifeno);

  BenefitMaster benefitMasterObj;
  double coverAmount;
  String lifeno;
  String policyNo;

  factory Benefit.fromRawJson(String str) => Benefit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        benefitMasterObj: json["benefitMaster"] != null
            ? BenefitMaster.fromJson(json["benefitMaster"])
            : BenefitMaster(),
        coverAmount: json["coverAmount"],
        lifeno: json["lifeNo"],
        policyNo: json["policyNo"],
      );

  Map<String, dynamic> toJson() => {
        "benefitMaster": benefitMasterObj.toJson(),
        "coverAmount": coverAmount,
        "lifeNo": lifeno,
        "policyNo": policyNo,
      };
}

class BenefitMaster extends BenefitMasterEntity {
  BenefitMaster({
    this.benefitCode,
    this.description,
    this.remarks,
    this.viewOrder,
  }) : super(
            description: description,
            benefitCode: benefitCode,
            remarks: remarks,
            viewOrder: viewOrder);

  String benefitCode;
  String description;
  String remarks;
  int viewOrder;

  factory BenefitMaster.fromRawJson(String str) =>
      BenefitMaster.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BenefitMaster.fromJson(Map<String, dynamic> json) => BenefitMaster(
        benefitCode: json["benefitCode"],
        description: json["description"],
        remarks: json["remarks"],
        viewOrder: json["viewOrder"],
      );

  Map<String, dynamic> toJson() => {
        "benefitCode": benefitCode,
        "description": description,
        "remarks": remarks,
        "viewOrder": viewOrder,
      };
}

class PolicyLoan extends PolicyLoanEntity {
  PolicyLoan(
      {this.lastCapitalizedDate,
      this.loanBalance,
      this.loanDate,
      this.loanNo,
      this.policyNo,
      this.loanReceiptsObj})
      : super(
            policyNo: policyNo,
            lastCapitalizedDate: lastCapitalizedDate,
            loanBalance: loanBalance,
            loanDate: loanDate,
            loanNo: loanNo,
            loanReceipts: loanReceiptsObj);

  String lastCapitalizedDate;
  double loanBalance;
  String loanDate;
  String loanNo;
  String policyNo;
  List<LoanReceipt> loanReceiptsObj;

  factory PolicyLoan.fromRawJson(String str) =>
      PolicyLoan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyLoan.fromJson(Map<String, dynamic> json) => PolicyLoan(
        lastCapitalizedDate: json["lastCapitalizedDate"],
        loanBalance: json["loanBalance"],
        loanDate: json["loanDate"],
        loanNo: json["loanNo"],
        policyNo: json["policyNo"],
        loanReceiptsObj: json["loanReceipts"] != null
            ? List<LoanReceipt>.from(
                json["loanReceipts"].map((x) => LoanReceipt.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "lastCapitalizedDate": lastCapitalizedDate,
        "loanBalance": loanBalance,
        "loanDate": loanDate,
        "loanNo": loanNo,
        "policyNo": policyNo,
        "loanReceipts":
            List<dynamic>.from(loanReceiptsObj.map((x) => x.toJson()))
      };
}

class LoanReceipt extends LoanReceiptEntity {
  LoanReceipt({
    this.policyNo,
    this.loanNo,
    this.receiptDate,
    this.amount,
  }) : super(
            policyNo: policyNo,
            loanNo: loanNo,
            amount: amount,
            receiptDate: receiptDate);

  String policyNo;
  String loanNo;
  DateTime receiptDate;
  double amount;

  factory LoanReceipt.fromRawJson(String str) =>
      LoanReceipt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoanReceipt.fromJson(Map<String, dynamic> json) => LoanReceipt(
        policyNo: json["policyNo"],
        loanNo: json["loanNo"],
        receiptDate: DateTime.parse(json["receiptDate"]),
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "policyNo": policyNo,
        "loanNo": loanNo,
        "receiptDate":
            "${receiptDate.year.toString().padLeft(4, '0')}-${receiptDate.month.toString().padLeft(2, '0')}-${receiptDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
      };
}
