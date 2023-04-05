import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/promotions_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/promotion_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetPromotions
    extends UseCase<PromotionResponseEntity, PromotionsRequestEntity> {
  final Repository repository;

  UseCaseGetPromotions({this.repository});

  @override
  Future<Either<Failure, PromotionResponseEntity>> call(
      PromotionsRequestEntity getPostRequest) async {
    return await repository.getPromotions(getPostRequest);
  }
}
