import 'package:ceylife_digital/features/data/models/requests/get_bank_branches_request.dart';

class GetBankBranchesRequestEntity extends GetBankBranchesRequest {
  GetBankBranchesRequestEntity({this.bankCode}) : super(bankCode: bankCode);

  String bankCode;
}
