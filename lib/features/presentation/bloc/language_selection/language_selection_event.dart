import 'package:ceylife_digital/features/presentation/bloc/base_event.dart';
import 'package:ceylife_digital/utils/enums.dart';

abstract class LanguageSelectionEvent extends BaseEvent {}

class SetLanguageEvent extends LanguageSelectionEvent {
  final Languages languages;
  bool isInitialValue;

  SetLanguageEvent(this.languages, {this.isInitialValue = false});
}

class GetLanguageEvent extends LanguageSelectionEvent {}
