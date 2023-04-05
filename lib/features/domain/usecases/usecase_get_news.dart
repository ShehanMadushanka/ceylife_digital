import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/news_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:huawei_map/constants/param.dart';

class UseCaseGetNews extends UseCase<GetNewsResponseEntity, Param> {
  final Repository repository;

  UseCaseGetNews({this.repository});

  @override
  Future<Either<Failure, GetNewsResponseEntity>> call(Param param) async {
    return await repository.getNews();
  }
}
