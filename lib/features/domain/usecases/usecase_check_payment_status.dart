import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/payment_status_check_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/payment_status_check_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseCheckPaymentStatus extends UseCase<
    PaymentStatusCheckResponseEntity, PaymentStatusCheckRequestEntity> {
  final Repository repository;

  UseCaseCheckPaymentStatus({this.repository});

  @override
  Future<Either<Failure, PaymentStatusCheckResponseEntity>> call(
      PaymentStatusCheckRequestEntity paymentStatusCheckRequestEntity) async {
    return await repository.checkPaymentStatus(paymentStatusCheckRequestEntity);
  }
}
