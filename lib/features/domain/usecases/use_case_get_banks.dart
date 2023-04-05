import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_banks_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:huawei_map/constants/param.dart';


class UseCaseGetBanks extends UseCase<BanksResponseEntity, Param> {
  final Repository repository;

  UseCaseGetBanks({this.repository});

  @override
  Future<Either<Failure, BanksResponseEntity>> call(Param param) async {
    return await repository.getBanks();
  }
}
