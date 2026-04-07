import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

class AuthService
    with ListenableServiceMixin
    implements InitializableDependency {
  static const String logInKey = 'log_in_preference';
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  Timer? _sessionTimer;
  final Duration sessionDuration = const Duration(minutes: 10);

  @override
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(logInKey) ?? false;
    if (_isLoggedIn) {
      _startSessionTimer();
    }
    notifyListeners();
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = true;

    await prefs.setBool(logInKey, true);
    _startSessionTimer();
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    await prefs.setBool(logInKey, false);
    _cancelSessionTimer();
    notifyListeners();
  }

  void _startSessionTimer() {
    _cancelSessionTimer();
    _sessionTimer = Timer(sessionDuration, () {
      logout();
    });
  }

  void _cancelSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = null;
  }
}
