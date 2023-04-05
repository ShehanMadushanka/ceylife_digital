import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/submit_bank_details_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/submit_bank_details_response_entity.dart';

import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseSubmitBankDetails
    extends UseCase<SubmitBankDetailsResponseEntity, SubmitBankDetailsRequestEntity> {
  final Repository repository;

  UseCaseSubmitBankDetails({this.repository});

  @override
  Future<Either<Failure, SubmitBankDetailsResponseEntity>> call(
      SubmitBankDetailsRequestEntity submitBankDetailsRequestEntity) async {
    return await repository.submitBankDetails(submitBankDetailsRequestEntity);
  }
}
