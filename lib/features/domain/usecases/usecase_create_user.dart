import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/create_user_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/create_user_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseCreateUser
    extends UseCase<CreateUserResponseEntity, CreateUserRequestEntity> {
  final Repository repository;

  UseCaseCreateUser({this.repository});

  @override
  Future<Either<Failure, CreateUserResponseEntity>> call(
      CreateUserRequestEntity createUserRequestEntity) async {
    return await repository.createUser(createUserRequestEntity);
  }
}
