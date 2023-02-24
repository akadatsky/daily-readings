import 'package:flutter/material.dart';
import 'all_locales.dart';


class LocaleProvider with ChangeNotifier {
  late Locale _locale;
  Locale get locale => _locale;
  void setLocale(Locale locale) {
    if (!AllLocale.availableLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}