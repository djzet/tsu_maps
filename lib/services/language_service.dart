import 'package:flutter/material.dart';

class LanguageService {
  static String _currentLanguage = 'ru';
  static final List<Function(String)> _listeners = [];

  static Future<void> saveLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    // Уведомляем всех слушателей об изменении языка
    for (var listener in _listeners) {
      listener(languageCode);
    }
  }

  static Future<String> getSavedLanguage() async {
    return _currentLanguage;
  }

  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en', '');
      case 'kk':
        return const Locale('kk', '');
      default:
        return const Locale('ru', '');
    }
  }

  static void addListener(Function(String) listener) {
    _listeners.add(listener);
  }

  static void removeListener(Function(String) listener) {
    _listeners.remove(listener);
  }
}
