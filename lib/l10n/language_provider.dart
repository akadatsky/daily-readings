// import 'package:flutter/cupertino.dart';
//
// class LanguageProvider with ChangeNotifier {
//   Locale _locale = const Locale('en');
//   Locale get locale => _locale;
//
//   Future<void> getLocale() async {
//     String? localeCode = await LocalStorage.instance.getLocale();
//     _locale = Locale.fromSubtags(languageCode: localeCode ?? 'en');
//     notifyListeners();
//   }
//
//   setLocale(String localeCode) async {
//     _locale = Locale.fromSubtags(languageCode: localeCode);
//     LocalStorage.instance.setLocale(localeCode);
//     notifyListeners();
//   }
// }