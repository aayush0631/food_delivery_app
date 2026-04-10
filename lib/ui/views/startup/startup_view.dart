import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return const Scaffold(
      body: Center(child: Text('hello')),
    );
  }

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.runStartupLogic();
    });
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
