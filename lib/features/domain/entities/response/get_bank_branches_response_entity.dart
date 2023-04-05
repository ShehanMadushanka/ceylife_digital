

import 'package:equatable/equatable.dart';

class GetBankBranchesResponseEntity extends Equatable {
  GetBankBranchesResponseEntity({
    this.responseCode,
    this.responseError,
    this.getBankBranches,
  });

  String responseCode;
  String responseError;
  List<GetBankBranchesEntity> getBankBranches;

  @override
  List<Object> get props =>
      [responseCode, responseError, getBankBranches];
}

class GetBankBranchesEntity extends Equatable {
  GetBankBranchesEntity({
   this.bankBranchId,
    this.bankCode,
    this.branchCode,
    this.branchName,
    this.createdTime,
    this.lastUpdatedTime,
    this.status
  });

 int bankBranchId;
 String bankCode;
 String branchCode;
 String branchName;
 String createdTime;
 String lastUpdatedTime;
 String status;

  @override
  List<Object> get props =>
      [bankBranchId,branchCode,bankCode,branchName,createdTime,lastUpdatedTime,status];
}
