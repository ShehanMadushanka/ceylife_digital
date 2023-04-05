import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_info_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_info_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetPolicyLoans
    extends UseCase<PolicyInfoResponseEntity, PolicyInfoRequestEntity> {
  final Repository repository;

  UseCaseGetPolicyLoans({this.repository});

  @override
  Future<Either<Failure, PolicyInfoResponseEntity>> call(
      PolicyInfoRequestEntity policyInfoRequestEntity) async {
    return await repository.getPolicyLoanData(policyInfoRequestEntity);
  }
}
