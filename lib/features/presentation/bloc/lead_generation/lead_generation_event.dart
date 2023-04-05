import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class LeadGenerationEvent extends BaseEvent {}

class LeadGeneration extends LeadGenerationEvent {
  final String accountHolderName;
  final String accountNo;
  final String bankCode;
  final int bankBranchId;

  LeadGeneration({
    this.accountHolderName,
    this.accountNo,
    this.bankCode,
    this.bankBranchId,
  });
}

class GetConfigData extends LeadGenerationEvent {}

class GetBanksEvent extends LeadGenerationEvent {}

class GetBankBranchesEvent extends LeadGenerationEvent {
  final String bankCode;

  GetBankBranchesEvent({this.bankCode});
}

class RegisterLeadGeneratorEvent extends LeadGenerationEvent {
  final int leadGeneratorId;
  final String nic;
  final String userName;
  final String nickName;
  final String password;
  final String repeatPassword;
  final int branchId;
  final String accountHolderName;
  final String accountNo;
  final String addressCity;
  final String addressLine1;
  final String addressLine2;
  final int bankBranchId;
  final String bankCode;
  final String contactNo;
  final String contactNo2;
  final String email;
  final String fullName;
  final bool isNewUser;

  RegisterLeadGeneratorEvent(
      {this.leadGeneratorId,
      this.nic,
      this.userName,
      this.nickName,
      this.password,
      this.repeatPassword,
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
      this.fullName,
      this.isNewUser});
}
