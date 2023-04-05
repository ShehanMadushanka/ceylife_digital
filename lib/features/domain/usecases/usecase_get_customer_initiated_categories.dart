import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/customer_initiated_category_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/customer_initiated_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetCustomerInitiatedCategories extends UseCase<
    CustomerInitiatedCategoryResponseEntity,
    CustomerInitiatedCategoryRequestEntity> {
  final Repository repository;

  UseCaseGetCustomerInitiatedCategories({this.repository});

  @override
  Future<Either<Failure, CustomerInitiatedCategoryResponseEntity>> call(
      CustomerInitiatedCategoryRequestEntity
          customerInitiatedCategoryRequestEntity) async {
    return await repository
        .getCustomerInitiatedCategories(customerInitiatedCategoryRequestEntity);
  }
}
