import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'startup_viewmodel.dart';
import 'package:week8/app/app.router.dart';

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
      home: const SizedBox(),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.runStartupLogic();
    });
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
