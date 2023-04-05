import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class DirectPayEvent extends BaseEvent {}

class CheckPaymentStatusEvent extends DirectPayEvent {
  final String referenceNumber;

  CheckPaymentStatusEvent({this.referenceNumber});
}
