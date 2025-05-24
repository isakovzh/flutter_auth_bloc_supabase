import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  final SharedPreferences prefs;
  static const String _languageKey = 'selected_language';

  LanguageCubit(this.prefs) : super(Locale(_getInitialLanguage(prefs)));

  static String _getInitialLanguage(SharedPreferences prefs) {
    final savedLang = prefs.getString(_languageKey);
    // Reset to English if Russian was previously selected
    if (savedLang == 'ru') {
      prefs.setString(_languageKey, 'en');
      return 'en';
    }
    return savedLang ?? 'en';
  }

  void setLanguage(String languageCode) {
    final newLocale = Locale(languageCode);
    prefs.setString(_languageKey, languageCode);
    emit(newLocale);
  }

  // Cycle through available languages
  void cycleLanguage() {
    final currentLang = state.languageCode;
    String newLang;

    switch (currentLang) {
      case 'en':
        newLang = 'ky';
        break;
      case 'ky':
        newLang = 'en';
        break;
      default:
        newLang = 'en';
    }

    setLanguage(newLang);
  }

  // Get language name for display
  String getCurrentLanguageName() {
    switch (state.languageCode) {
      case 'en':
        return 'English';
      case 'ky':
        return 'Кыргызча';
      default:
        return 'English';
    }
  }
}
