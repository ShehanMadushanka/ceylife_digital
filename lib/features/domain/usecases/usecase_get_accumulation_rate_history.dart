import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/accumulation_rate_history_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/accumulation_rate_history_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseAccumulationRateHistory extends UseCase<
    AccumulationRateHistoryResponseEntity,
    AccumulationRateHistoryRequestEntity> {
  final Repository repository;

  UseCaseAccumulationRateHistory({this.repository});

  @override
  Future<Either<Failure, AccumulationRateHistoryResponseEntity>> call(
      AccumulationRateHistoryRequestEntity
          accumulationRateHistoryRequestEntity) async {
    return await repository
        .getAccumulationRateHistory(accumulationRateHistoryRequestEntity);
  }
}
