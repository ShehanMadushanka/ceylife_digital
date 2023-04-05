import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCasePasswordReset
    extends UseCase<PasswordResetResponseEntity, PasswordResetRequestEntity> {
  final Repository repository;

  UseCasePasswordReset({this.repository});

  @override
  Future<Either<Failure, PasswordResetResponseEntity>> call(
      PasswordResetRequestEntity passwordResetRequestEntity) async {
    return await repository.passwordReset(passwordResetRequestEntity);
  }
}
