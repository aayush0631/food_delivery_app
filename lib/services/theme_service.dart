import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

class ThemeService
    with ListenableServiceMixin
    implements InitializableDependency {
  static const String themeKey = 'theme_preference';

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  @override
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(themeKey) ?? false;
    notifyListeners();
  }

  Future<void> setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = isDarkMode;

    await prefs.setBool(themeKey, isDarkMode);
    notifyListeners();
  }

  void toggleTheme() {
    setTheme(!_isDarkMode);
  }
}
