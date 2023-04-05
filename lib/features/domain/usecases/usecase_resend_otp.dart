import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/resend_otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/resend_otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseResendOtp
    extends UseCase<ResendOtpResponseEntity, ResendOtpRequestEntity> {
  final Repository repository;

  UseCaseResendOtp({this.repository});

  @override
  Future<Either<Failure, ResendOtpResponseEntity>> call(
      ResendOtpRequestEntity resendOtpRequestEntity) async {
    return await repository.resendOtp(resendOtpRequestEntity);
  }
}
