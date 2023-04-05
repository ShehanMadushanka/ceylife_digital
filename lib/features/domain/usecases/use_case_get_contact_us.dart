import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/contact_us_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetContactUs extends UseCase<List<ContactUsEntity>, NoParams> {
  final Repository repository;

  UseCaseGetContactUs({this.repository});

  @override
  Future<Either<Failure, List<ContactUsEntity>>> call(NoParams params) {
    return repository.getContactUs();
  }
}
