import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/policy_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/policy_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetPolicy extends UseCase<PolicyResponseEntity, PolicyRequestEntity> {
  final Repository repository;

  UseCaseGetPolicy({this.repository});

  @override
  Future<Either<Failure, PolicyResponseEntity>> call(
      PolicyRequestEntity policyRequestEntity) async {
    return await repository.getPolicy(policyRequestEntity);
  }
}
