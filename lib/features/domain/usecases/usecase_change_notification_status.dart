import 'package:ceylife_digital/core/usecase/usecase.dart';
import 'package:ceylife_digital/error/failures.dart';
import 'package:ceylife_digital/features/domain/entities/request/notification_status_change_request_entity.dart';
import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class UseCaseChangeNotificationStatus extends UseCase<
    GetNotificationResponseEntity, NotificationStatusChangeRequestEntity> {
  final Repository repository;

  UseCaseChangeNotificationStatus({this.repository});

  @override
  Future<Either<Failure, GetNotificationResponseEntity>> call(
      NotificationStatusChangeRequestEntity
          notificationStatusChangeRequestEntity) async {
    return await repository
        .changeNotificationStatus(notificationStatusChangeRequestEntity);
  }
}
