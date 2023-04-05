import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/update_password_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/update_password_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseUpdatePassword
    extends UseCase<UpdatePasswordResponseEntity, UpdatePasswordRequestEntity> {
  final Repository repository;

  UseCaseUpdatePassword({this.repository});

  @override
  Future<Either<Failure, UpdatePasswordResponseEntity>> call(
      UpdatePasswordRequestEntity updatePasswordRequestEntity) async {
    return await repository.updatePassword(updatePasswordRequestEntity);
  }
}
