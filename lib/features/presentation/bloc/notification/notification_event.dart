import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class NotificationEvent extends BaseEvent {}

class GetNotificationsEvent extends NotificationEvent {}

class ChangeNotificationStatusEvent extends NotificationEvent{
  final List<int> idList;
  final String status;

  ChangeNotificationStatusEvent({this.idList, this.status});
}
