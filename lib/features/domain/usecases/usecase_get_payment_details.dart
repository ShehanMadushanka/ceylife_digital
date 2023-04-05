import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_details_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCasePaymentDetails
    extends UseCase<PaymentDetailsResponseEntity, PaymentDetailsRequestEntity> {
  final Repository repository;

  UseCasePaymentDetails({this.repository});

  @override
  Future<Either<Failure, PaymentDetailsResponseEntity>> call(
      PaymentDetailsRequestEntity paymentDetailsRequestEntity) async {
    return await repository.getPaymentDetails(paymentDetailsRequestEntity);
  }
}
