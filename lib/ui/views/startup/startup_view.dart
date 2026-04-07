import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';
import 'package:week8/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return MaterialApp(
      title: 'Week8 App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: viewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: Routes.loginView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
