// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// //import 'package:stacked_generator/utils.dart';
//
// class ThemeProvider with ChangeNotifier {
//   late SharedPreferences _prefs;
//
//   ThemeMode _themeMode = ThemeMode.light;
//
//   ThemeProvider() {
//     initTheme();
//   }
//
//   ThemeMode getThemeMode() => _themeMode;
//
//   // Getter to check if dark mode is enabled or not
//   bool get isDarkModeEnabled => (_themeMode == ThemeMode.dark);
//
//   Future<void> setThemeMode(ThemeMode mode) async {
//     _themeMode = mode;
//     _prefs = await SharedPreferences.getInstance();
//     await _prefs.setString('theme', mode.toString());
//     notifyListeners();
//   }
//
//   Future<void> initTheme() async {
//     _prefs = await SharedPreferences.getInstance();
//     final savedTheme = _prefs.getString('theme');
//     if (savedTheme != null) {
//       _themeMode = ThemeMode.values.firstWhere(
//             (element) => element.toString() == savedTheme,
//         orElse: () => ThemeMode.light,
//       );
//     }
//     notifyListeners();
//   }
// }
//
