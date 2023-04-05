import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/health_tips_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/health_tip_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetHealthTips
    extends UseCase<HealthTipsResponseEntity, HealthTipsRequestEntity> {
  final Repository repository;

  UseCaseGetHealthTips({this.repository});

  @override
  Future<Either<Failure, HealthTipsResponseEntity>> call(
      HealthTipsRequestEntity healthTipsRequestEntity) async {
    return await repository.getHealthTips(healthTipsRequestEntity);
  }
}
