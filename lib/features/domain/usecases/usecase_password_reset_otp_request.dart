import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/password_reset_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/password_reset_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCasePasswordResetOtpRequest extends UseCase<
    PasswordResetOtpResponseEntity, PasswordResetOtpRequestEntity> {
  final Repository repository;

  UseCasePasswordResetOtpRequest({this.repository});

  @override
  Future<Either<Failure, PasswordResetOtpResponseEntity>> call(
      PasswordResetOtpRequestEntity passwordResetOtpRequestEntity) async {
    return await repository
        .passwordResetOtpRequest(passwordResetOtpRequestEntity);
  }
}
