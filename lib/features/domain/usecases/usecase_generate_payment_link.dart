import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/generate_payment_link_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/generate_payment_link_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGeneratePaymentLink extends UseCase<
    GeneratePaymentLinkResponseEntity, GeneratePaymentLinkRequestEntity> {
  final Repository repository;

  UseCaseGeneratePaymentLink({this.repository});

  @override
  Future<Either<Failure, GeneratePaymentLinkResponseEntity>> call(
      GeneratePaymentLinkRequestEntity generatePaymentLinkRequestEntity) async {
    return await repository.getPaymentLink(generatePaymentLinkRequestEntity);
  }
}
