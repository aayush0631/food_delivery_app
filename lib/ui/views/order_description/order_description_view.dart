import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'order_description_viewmodel.dart';

class OrderDescriptionView extends StackedView<OrderDescriptionViewModel> {
  const OrderDescriptionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrderDescriptionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("OrderDescriptionView")),
      ),
    );
  }

  @override
  OrderDescriptionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrderDescriptionViewModel();
}
