import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/rates_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseAccumulationRate
    extends UseCase<AccumulationRateResponseEntity, NoParams> {
  final Repository repository;

  UseCaseAccumulationRate({this.repository});

  @override
  Future<Either<Failure, AccumulationRateResponseEntity>> call(
      NoParams noParams) async {
    return await repository.getAccumulationRate();
  }
}
