import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/key_exchange_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/key_exchange_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseKeyExchange
    extends UseCase<KeyExchangeResponseEntity, KeyExchangeRequestEntity> {
  final Repository repository;

  UseCaseKeyExchange({this.repository});

  @override
  Future<Either<Failure, KeyExchangeResponseEntity>> call(
      KeyExchangeRequestEntity keyExchangeRequestEntity) async {
    return await repository.keyExchange(keyExchangeRequestEntity);
  }
}
