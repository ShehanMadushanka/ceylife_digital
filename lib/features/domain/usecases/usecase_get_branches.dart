import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/branches_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetBranches
    extends UseCase<BranchResponseEntity, BranchesRequestEntity> {
  final Repository repository;

  UseCaseGetBranches({this.repository});

  @override
  Future<Either<Failure, BranchResponseEntity>> call(
      BranchesRequestEntity getBranchesRequest) async {
    return await repository.getBranches(getBranchesRequest);
  }
}
