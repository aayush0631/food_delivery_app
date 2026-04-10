import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/models/order_item.dart';
import 'package:week8/ui/views/order_description/widgets/cooking_tracking_animation.dart';
import 'order_description_viewmodel.dart';


class OrderDescriptionView extends StackedView<OrderDescriptionViewModel> {
  final OrderItem order;
  const OrderDescriptionView({Key? key, required this.order}) : super(key: key);

  @override
  void onViewModelReady(OrderDescriptionViewModel viewModel) {
    viewModel.startCooking();
  }

  @override
  Widget builder(
    BuildContext context,
    OrderDescriptionViewModel viewModel,
    Widget? child,
  ) {
    final order = viewModel.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text("orders"),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(child:CookingAnimation(order: order),)
    );
  }

  @override
  OrderDescriptionViewModel viewModelBuilder(BuildContext context) =>
      OrderDescriptionViewModel(order: order);
}

