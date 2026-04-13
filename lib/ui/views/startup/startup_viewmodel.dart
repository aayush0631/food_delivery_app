import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/services/auth_service.dart';

class StartupViewModel extends BaseViewModel {
  final _loginService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  bool get isLoggedIn => _loginService.isLoggedIn;

  void runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    if (isLoggedIn) {
      _navigationService.replaceWithMainView();
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}
