import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCasePolicyDetails
    extends UseCase<PolicyDetailsResponseEntity, PolicyDetailsRequestEntity> {
  final Repository repository;

  UseCasePolicyDetails({this.repository});

  @override
  Future<Either<Failure, PolicyDetailsResponseEntity>> call(
      PolicyDetailsRequestEntity policyDetailsRequestEntity) async {
    return await repository.getPolicyDetails(policyDetailsRequestEntity);
  }
}
