import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/otp_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/otp_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetOtp extends UseCase<OtpResponseEntity, OtpRequestEntity> {
  final Repository repository;

  UseCaseGetOtp({this.repository});

  @override
  Future<Either<Failure, OtpResponseEntity>> call(
      OtpRequestEntity otpRequestEntity) async {
    return await repository.getOtp(otpRequestEntity);
  }
}
