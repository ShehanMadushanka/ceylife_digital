import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/product_category_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:huawei_map/constants/param.dart';

class UseCaseGetProductCategories
    extends UseCase<ProductCategoryEntityResponse, Param> {
  final Repository repository;

  UseCaseGetProductCategories({this.repository});

  @override
  Future<Either<Failure, ProductCategoryEntityResponse>> call(
      Param param) async {
    return await repository.getProductCategories();
  }
}
