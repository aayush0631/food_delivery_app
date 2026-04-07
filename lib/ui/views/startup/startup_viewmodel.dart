import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/services/theme_service.dart';

class StartupViewModel extends ReactiveViewModel {
  final _themeService = locator<ThemeService>();

  bool get isDarkMode => _themeService.isDarkMode;

  @override
  List<ListenableServiceMixin> get listenableServices => [_themeService];
}
