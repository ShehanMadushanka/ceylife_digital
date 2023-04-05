import 'package:ceylife_digital/features/data/models/requests/submit_bank_details_request.dart';

class SubmitBankDetailsRequestEntity extends SubmitBankDetailsRequest {
  SubmitBankDetailsRequestEntity({
    this.accountHolderName,
    this.accountNo,
    this.bankCode,
    this.bankBranchId,
    this.leadGeneratorId,
  }) : super(
            accountHolderName: accountHolderName,
            accountNo: accountNo,
            bankCode: bankCode,
            bankBranchId: bankBranchId,
            leadGeneratorId: leadGeneratorId);

  String accountHolderName;
  String accountNo;
  String bankCode;
  int bankBranchId;
  int leadGeneratorId;
}
