import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/initiate_customer_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/initiate_customer_service_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseInitiateCustomerService extends UseCase<
    InitiateCustomerServiceResponseEntity,
    InitiateCustomerServiceRequestEntity> {
  final Repository repository;

  UseCaseInitiateCustomerService({this.repository});

  @override
  Future<Either<Failure, InitiateCustomerServiceResponseEntity>> call(
      InitiateCustomerServiceRequestEntity
          initiateCustomerServiceRequestEntity) async {
    return await repository
        .initiateCustomerServiceRequest(initiateCustomerServiceRequestEntity);
  }
}
