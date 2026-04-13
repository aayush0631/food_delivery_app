import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/app/app.router.dart';
import 'package:week8/services/auth_service.dart';
import 'package:week8/ui/views/login/login_view.form.dart';

class LoginViewModel extends FormViewModel with $LoginView {
  // ignore: unused_field
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  static const String name = 'aayush';
  static const String email = 'aayu@gmail.com';
  static const String password = 'stha';

  void login() {
    // final username = usernameController.text;
    // final pass = passwordController.text;
    // final mail = emailController.text;

    // if (username == name && pass == password && mail == email) {
    //   _authService.login();
    //   _navigationService.replaceWithFoodMenuView();
    // } else {
    //   _navigationService.replaceWithStartupView();
    // }
    if (true) {
      _navigationService.replaceWithMainView();
    }
  }

  // @override
  // void dispose() {
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   emailController.dispose();
  //   super.dispose();
  // }
}
