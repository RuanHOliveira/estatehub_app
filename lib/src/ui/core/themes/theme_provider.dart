import 'package:estatehub_app/src/ui/core/themes/dark_mode.dart';
import 'package:estatehub_app/src/ui/core/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _prefKey = 'THEME_MODE';

  ThemeData _themeData = lightMode;
  bool _loaded = false;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  bool get isLoaded => _loaded;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, isDarkMode ? 'D' : 'L');
  }

  Future<void> initializeTheme() async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey) ?? 'L';

    _themeData = (saved == 'D') ? darkMode : lightMode;
    _loaded = true;
    notifyListeners();
  }

  Future<void> setDark(bool dark) async {
    _themeData = dark ? darkMode : lightMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, dark ? 'D' : 'L');
  }
}
