import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _key = 'isDarkMode';
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(ThemeMode.light);

  /// Load saved theme at startup
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? false;
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Toggle theme + save
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeModeNotifier.value == ThemeMode.dark;
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
    themeModeNotifier.value = newTheme;
    await prefs.setBool(_key, newTheme == ThemeMode.dark);
  }
}
