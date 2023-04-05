import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_bloc.dart';
import 'package:ceylife_digital/features/presentation/bloc/base_state.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_event.dart';
import 'package:ceylife_digital/features/presentation/bloc/language_selection/language_selection_state.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';

class LanguageSelectionBloc extends BaseBloc<LanguageSelectionEvent,
    BaseState<LanguageSelectionState>> {
  final AppSharedData appSharedData;

  LanguageSelectionBloc({this.appSharedData})
      : super(InitialLanguageSelectionState());

  @override
  Stream<BaseState<LanguageSelectionState>> mapEventToState(
      LanguageSelectionEvent event) async* {
    if (event is GetLanguageEvent) {
      final language = await appSharedData.getAppLanguage();
      if (language != null) {
        AppConstants.APP_LANGUAGE = language.getLanguage();
        yield LanguageLoadedState(languages: language.getLanguage());
      } else {
        appSharedData.setAppLanguage(Languages.ENGLISH.getValue());
        AppConstants.APP_LANGUAGE = Languages.ENGLISH;
        yield LanguageLoadedState(languages: Languages.ENGLISH);
      }
    } else if (event is SetLanguageEvent) {
      appSharedData.setAppLanguage(event.languages.getValue());
      if (event.isInitialValue) appSharedData.setInitialLaunch();
      AppConstants.APP_LANGUAGE = event.languages;
      yield LanguageChangeState(languages: event.languages);
    }
  }
}
