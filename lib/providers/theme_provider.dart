import 'package:bit_wall/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  static const String themePreferenceKey = 'theme_preference';

  ThemeProvider() {
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themePreference = prefs.getInt(themePreferenceKey);

    if (themePreference != null && themePreference == 1) {
      _themeData = darkMode;
    }
    notifyListeners();
  }

  set themeData(ThemeData ThemeData) {
    _themeData = ThemeData;
    _saveTheme();
    notifyListeners();
  }

  _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_themeData == darkMode) {
      await prefs.setInt(themePreferenceKey, 1);
    } else {
      await prefs.setInt(themePreferenceKey, 0);
    }
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    _saveTheme();
    notifyListeners();
  }
}
