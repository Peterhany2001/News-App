import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLanguage = 'en';
  ThemeMode currentTheme = ThemeMode.light;

  SettingsProvider() {
    loadSettings();
  }

  void changeLanguage(String newLanguage) async {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
  }

  void changeTheme(ThemeMode newTheme) async {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newTheme == ThemeMode.light ? 'light' : 'dark');
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    String? theme = prefs.getString('theme');

    if (lang != null) {
      currentLanguage = lang;
    }
    if (theme != null) {
      currentTheme = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    }
    notifyListeners();
  }
}
