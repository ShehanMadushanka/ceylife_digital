import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';

abstract class PolicyEvent extends BaseEvent {}

class GetPolicyEvent extends PolicyEvent {
  final String key;
  final int keyType;
  final int registrationType;

  GetPolicyEvent({this.key, this.keyType, this.registrationType});
}
