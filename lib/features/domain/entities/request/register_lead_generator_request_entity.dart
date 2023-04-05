import 'package:ceylife_digital/features/data/models/requests/register_lead_generator_request.dart';

class RegisterLeadGeneratorRequestEntity extends RegisterLeadGeneratorRequest {
  RegisterLeadGeneratorRequestEntity(
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
      this.fullName})
      : super(
            leadGeneratorId: leadGeneratorId,
            nic: nic,
            userName: userName,
            nickName: nickName,
            password: password,
            branchId: branchId,
            accountHolderName: accountHolderName,
            accountNo: accountNo,
            addressCity: addressCity,
            addressLine1: addressLine1,
            addressLine2: addressLine2,
            bankBranchId: bankBranchId,
            bankCode: bankCode,
            contactNo: contactNo,
            contactNo2: contactNo2,
            email: email,
            fullName: fullName);

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
}
