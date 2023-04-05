import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_bank_branches_request_entity.dart';

import 'package:ceylife_digital/features/domain/entities/response/get_bank_branches_response_entity.dart';

import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetBankBranches
    extends UseCase<GetBankBranchesResponseEntity, GetBankBranchesRequestEntity> {
  final Repository repository;

  UseCaseGetBankBranches({this.repository});

  @override
  Future<Either<Failure, GetBankBranchesResponseEntity>> call(
      GetBankBranchesRequestEntity getBranchesRequest) async {
    return await repository.getBankBranches(getBranchesRequest);
  }
}
