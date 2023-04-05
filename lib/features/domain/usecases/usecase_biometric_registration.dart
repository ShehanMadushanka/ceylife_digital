import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/biometric_registration_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/biometric_registration_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseBiometricRegistration extends UseCase<
    BiometricRegistrationResponseEntity, BiometricRegistrationRequestEntity> {
  final Repository repository;

  UseCaseBiometricRegistration({this.repository});

  @override
  Future<Either<Failure, BiometricRegistrationResponseEntity>> call(
      BiometricRegistrationRequestEntity biometricRegistrationRequestEntity) {
    return repository.biometricRegistration(biometricRegistrationRequestEntity);
  }
}
