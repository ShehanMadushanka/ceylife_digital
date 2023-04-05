import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/login_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/login_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetLogin extends UseCase<LoginResponseEntity, LoginRequestEntity> {
  final Repository repository;

  UseCaseGetLogin({this.repository});

  @override
  Future<Either<Failure, LoginResponseEntity>> call(
      LoginRequestEntity loginRequestEntity) async {
    return await repository.getLogin(loginRequestEntity);
  }
}
