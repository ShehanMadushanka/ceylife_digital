import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/faq_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:huawei_map/constants/param.dart';

class UseCaseGetFAQ extends UseCase<FAQResponseEntity, Param> {
  final Repository repository;

  UseCaseGetFAQ({this.repository});

  @override
  Future<Either<Failure, FAQResponseEntity>> call(Param param) async {
    return await repository.getFAQ();
  }
}
