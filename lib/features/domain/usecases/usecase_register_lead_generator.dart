import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/register_lead_generator_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/register_lead_generator_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseRegisterLeadGenerator extends UseCase<
    RegisterLeadGeneratorResponseEntity, RegisterLeadGeneratorRequestEntity> {
  final Repository repository;

  UseCaseRegisterLeadGenerator({this.repository});

  @override
  Future<Either<Failure, RegisterLeadGeneratorResponseEntity>> call(
      RegisterLeadGeneratorRequestEntity
          registerLeadGeneratorRequestEntity) async {
    return await repository
        .registerLeadGenerator(registerLeadGeneratorRequestEntity);
  }
}
