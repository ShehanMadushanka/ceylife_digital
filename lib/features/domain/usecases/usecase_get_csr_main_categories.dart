import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_csr_main_category_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetCSRMainCategories
    extends UseCase<GetCsrMainCategoryResponseEntity, NoParams> {
  final Repository repository;

  UseCaseGetCSRMainCategories({this.repository});

  @override
  Future<Either<Failure, GetCsrMainCategoryResponseEntity>> call(
      NoParams params) async {
    return await repository.getCSRMainCategories();
  }
}
