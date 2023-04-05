import 'package:equatable/equatable.dart';

class PolicyInfoResponseEntity extends Equatable {
  PolicyInfoResponseEntity({
    this.benefits,
    this.policyLoans,
    this.responseCode,
    this.responseError,
  });

  List<BenefitEntity> benefits;
  List<PolicyLoanEntity> policyLoans;
  String responseCode;
  String responseError;

  @override
  List<Object> get props =>
      [benefits, policyLoans, responseCode, responseError];
}

class BenefitEntity extends Equatable {
  BenefitEntity({
    this.benefitMaster,
    this.coverAmount,
    this.lifeno,
    this.policyNo,
  });

  BenefitMasterEntity benefitMaster;
  double coverAmount;
  String lifeno;
  String policyNo;

  @override
  List<Object> get props => [benefitMaster, coverAmount, lifeno, policyNo];
}

class BenefitMasterEntity extends Equatable {
  BenefitMasterEntity({
    this.benefitCode,
    this.description,
    this.remarks,
    this.viewOrder,
  });

  String benefitCode;
  String description;
  String remarks;
  int viewOrder;

  @override
  List<Object> get props => [benefitCode, description, remarks, viewOrder];
}

class PolicyLoanEntity extends Equatable {
  PolicyLoanEntity({
    this.lastCapitalizedDate,
    this.loanBalance,
    this.loanDate,
    this.loanNo,
    this.policyNo,
    this.loanReceipts
  });

  String lastCapitalizedDate;
  double loanBalance;
  String loanDate;
  String loanNo;
  String policyNo;
  List<LoanReceiptEntity> loanReceipts;

  @override
  List<Object> get props =>
      [lastCapitalizedDate, loanBalance, loanDate, loanNo, policyNo];
}

class LoanReceiptEntity extends Equatable{
  LoanReceiptEntity({
    this.policyNo,
    this.loanNo,
    this.receiptDate,
    this.amount,
  });

  String policyNo;
  String loanNo;
  DateTime receiptDate;
  double amount;

  @override
  List<Object> get props => [policyNo, loanNo, receiptDate, amount];
}
