import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/production_detail_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_type_data_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetProductDetail extends UseCase<GetProductDetailResponseEntity,
    ProductDetailRequestEntity> {
  final Repository repository;

  UseCaseGetProductDetail({this.repository});

  @override
  Future<Either<Failure, GetProductDetailResponseEntity>> call(
      ProductDetailRequestEntity param) async {
    return await repository.getProductDetails(param);
  }
}
