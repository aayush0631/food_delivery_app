import 'package:flutter/material.dart';
import 'package:week8/app/app.bottomsheets.dart';
import 'package:week8/app/app.dialogs.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/services/auth_service.dart';
import 'package:week8/services/theme_service.dart';
import 'package:week8/ui/views/startup/startup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await locator<ThemeService>().init();
  await locator<AuthService>().init();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const StartupView());
}
