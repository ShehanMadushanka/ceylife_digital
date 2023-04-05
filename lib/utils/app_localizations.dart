import 'dart:async';
import 'dart:convert';

import 'package:ceylife_digital/core/service/dependency_injection.dart';
import 'package:ceylife_digital/features/data/datasources/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load(Locale locale) async {
    this.locale = locale;
    // Save the language preference
    AppSharedData appSharedData = injection<AppSharedData>();
    appSharedData.setAppLanguage(locale.languageCode);
    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('preferred_language', locale.languageCode);*/
    // Load the language JSON file from the "lang" folder

    //Files should be initially stored in the an array and not read every single time.
    String jsonString =
        await rootBundle.loadString('locales/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'si', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppSharedData appSharedData = injection<AppSharedData>();
    final language = await appSharedData.getAppLanguage();
    AppLocalizations localizations = new AppLocalizations(
        language != null ? Locale.fromSubtags(languageCode: language) : locale);
    await localizations.load(
        language != null ? Locale.fromSubtags(languageCode: language) : locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
