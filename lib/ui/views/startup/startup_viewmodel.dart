import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/services/auth_service.dart';
import 'package:week8/services/theme_service.dart';

class StartupViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();

  final _themeService = locator<ThemeService>();
  final _loginService = locator<AuthService>();

  bool get isDarkMode => _themeService.isDarkMode;
  bool get isLoggedIn => _loginService.isLoggedIn;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_themeService, _loginService];

  void runStartupLogic() {
    if (isLoggedIn) {
      _navigationService.replaceWithFoodMenuView();
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}
