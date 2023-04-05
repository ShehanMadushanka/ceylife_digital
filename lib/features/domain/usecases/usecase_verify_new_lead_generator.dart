import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/verify_new_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/verify_new_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseNewLeadGenerator
    extends UseCase<VerifyNewLeadGeneratoResponseEntity, VerifyNewLeadGeneratorRequestEntity> {
  final Repository repository;

  UseCaseNewLeadGenerator({this.repository});

  @override
  Future<Either<Failure, VerifyNewLeadGeneratoResponseEntity>> call(
      VerifyNewLeadGeneratorRequestEntity verifyNewLeadGeneratorRequestEntity) async {
    return await repository.verifyNewLeadGenerator(verifyNewLeadGeneratorRequestEntity);
  }
}
