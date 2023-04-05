import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_service_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetCustomerInitiatedService extends UseCase<
    CustomerInitiatedServiceResponseEntity,
    CustomerInitiatedServiceRequestEntity> {
  final Repository repository;

  UseCaseGetCustomerInitiatedService({this.repository});

  @override
  Future<Either<Failure, CustomerInitiatedServiceResponseEntity>> call(
      CustomerInitiatedServiceRequestEntity
          customerInitiatedServiceRequestEntity) async {
    return await repository
        .getCustomerInitiatedService(customerInitiatedServiceRequestEntity);
  }
}
