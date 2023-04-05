import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class HealthTipsEvent extends BaseEvent {}

class GetHealthTips extends HealthTipsEvent {
  bool fromHome;

  GetHealthTips({this.fromHome = false});
}
