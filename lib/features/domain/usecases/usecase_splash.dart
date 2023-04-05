import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/splash_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/splash_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseSplash extends UseCase<SplashResponseEntity, SplashRequestEntity> {
  final Repository repository;

  UseCaseSplash({this.repository});

  @override
  Future<Either<Failure, SplashResponseEntity>> call(
      SplashRequestEntity splashRequestEntity) async {
    return await repository.splashRequest(splashRequestEntity);
  }
}
