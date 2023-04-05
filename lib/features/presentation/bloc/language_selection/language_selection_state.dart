import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/utils/enums.dart';

abstract class LanguageSelectionState
    extends BaseState<LanguageSelectionState> {}

class InitialLanguageSelectionState extends LanguageSelectionState {}

class LanguageLoadedState extends LanguageSelectionState {
  final Languages languages;

  LanguageLoadedState({this.languages});
}

class LanguageChangeState extends LanguageSelectionState {
  final Languages languages;

  LanguageChangeState({this.languages});
}
