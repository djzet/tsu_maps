import 'dart:async';

import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'ru': {
      'app_title': 'TSU Карты',
      'select_language': 'Выберите язык',
      'select_language_subtitle': 'Select language',
      'russian': 'Русский',
      'english': 'English',
      'kazakh': 'Қазақша',
      'welcome': 'Добро пожаловать',
      'welcome_message': 'Добро пожаловать в TSU Карты',
      'button_text': 'Нажми',
    },
    'en': {
      'app_title': 'TSU Maps',
      'select_language': 'Select language',
      'select_language_subtitle': 'Choose your language',
      'russian': 'Russian',
      'english': 'English',
      'kazakh': 'Kazakh',
      'welcome': 'Welcome',
      'welcome_message': 'Welcome to TSU Maps',
      'button_text': 'Press',
    },
    'kk': {
      'app_title': 'TSU Карталары',
      'select_language': 'Тілді таңдаңыз',
      'select_language_subtitle': 'Тіліңізді таңдаңыз',
      'russian': 'Орысша',
      'english': 'Ағылшынша',
      'kakakh': 'Қазақша',
      'welcome': 'Қош келдіңіз',
      'welcome_message': 'TSU Карталарына қош келдіңіз',
      'button_text': 'Басу',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ru', 'en', 'kk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
