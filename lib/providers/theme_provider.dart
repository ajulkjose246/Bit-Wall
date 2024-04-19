import 'package:bit_wall/services/shared_preferences.dart';
import 'package:bit_wall/themes/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  static const String themePreferenceKey = 'theme_preference';

  ThemeProvider() {
    _loadTheme();
  }

  _loadTheme() async {
    int? themePreference =
        SharedPreferencesService().getInt(themePreferenceKey);

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
    if (_themeData == darkMode) {
      SharedPreferencesService().storeInt(themePreferenceKey, 1);
    } else {
      SharedPreferencesService().storeInt(themePreferenceKey, 0);
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
