import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';
import 'package:lottie/lottie.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/loading.json',
          width: 180,
          repeat: true,
        ),
      ),
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
