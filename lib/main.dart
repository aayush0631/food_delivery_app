import 'package:flutter/material.dart';
import 'package:week8/app/app.bottomsheets.dart';
import 'package:week8/app/app.dialogs.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/locator_setup.dart';
import 'package:week8/ui/views/startup/startup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await setupCustomLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const StartupView());
}