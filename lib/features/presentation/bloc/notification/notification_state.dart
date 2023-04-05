import 'package:ceylife_digital/features/domain/entities/response/get_notification_response_entity.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';

abstract class NotificationState extends BaseState<NotificationState> {}

class InitialNotificationState extends NotificationState {}

class NotificationLoadedState extends NotificationState{
  final GetNotificationResponseEntity getNotificationResponseEntity;

  NotificationLoadedState({this.getNotificationResponseEntity});
}

class NotificationLoadingFailedState extends NotificationState{}

class NotificationStatusChangeSuccessState extends NotificationState{
  final GetNotificationResponseEntity getNotificationResponseEntity;

  NotificationStatusChangeSuccessState({this.getNotificationResponseEntity});
}