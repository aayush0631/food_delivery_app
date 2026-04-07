import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/ui/views/login/login_view.form.dart';

class LoginViewModel extends FormViewModel with $LoginView {
  final _navigationService = locator<NavigationService>();

  static const String name = 'aayush';
  static const String email = 'aayu@gmail.com';
  static const String password = 'stha';

  void login() {
    final username = usernameController.text;
    final pass = passwordController.text;
    final mail = emailController.text;

    if (username == name && pass == password && mail == email) {
      _navigationService.replaceWithFoodMenuView();
    } else {
      _navigationService.replaceWithStartupView();
    }
  }
}
