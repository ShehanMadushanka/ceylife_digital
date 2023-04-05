import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/get_notification_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseGetNotifications extends UseCase<GetNotificationResponseEntity,
    GetNotificationRequestEntity> {
  final Repository repository;

  UseCaseGetNotifications({this.repository});

  @override
  Future<Either<Failure, GetNotificationResponseEntity>> call(
      GetNotificationRequestEntity getNotificationRequestEntity) async {
    return await repository.getNotifications(getNotificationRequestEntity);
  }
}
