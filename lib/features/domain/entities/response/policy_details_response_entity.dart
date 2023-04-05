// To parse this JSON data, do
//
//     final policyDetailsResponse = policyDetailsResponseFromJson(jsonString);

import 'package:ceylife_digital/utils/enums.dart';
import 'package:equatable/equatable.dart';

class PolicyDetailsResponseEntity extends Equatable {
  PolicyDetailsResponseEntity({
    this.data,
    this.responseCode,
    this.responseError,
  });

  List<PolicyDetailItemEntity> data;
  String responseCode;
  String responseError;

  @override
  List<Object> get props => [data, responseError, responseCode];
}

class PolicyDetailItemEntity extends Equatable {
  PolicyDetailItemEntity({
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
    this.policyStatusEnum = PolicyStatus.BUYONLINE,
  });

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
  PolicyStatus policyStatusEnum;

  @override
  List<Object> get props => [accountBalance, branch, clientNo, interest, name];
}
