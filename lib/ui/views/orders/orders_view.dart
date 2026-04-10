import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'orders_viewmodel.dart';

class OrdersView extends StackedView<OrdersViewModel> {
  const OrdersView({Key? key}) : super(key: key);

    @override
  void onViewModelReady(OrdersViewModel viewModel) {
    viewModel.fetchOrderedItems();
  }

  @override
  Widget builder(
    BuildContext context,
    OrdersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("orders"),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              onPressed: viewModel.toggleTheme,
              icon: const Icon(Icons.brightness_6)),
          IconButton(
              onPressed: viewModel.nav, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: viewModel.hasError
          ? Center(
              child: Text(viewModel.modelError ?? 'Something went wrong'),
            )
          : viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.orders.isEmpty
                  ? const Center(child: Text('No orders yet'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: viewModel.orders.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final orders = viewModel.orders[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.navigateeToOrderDescrition();
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: orders.id!,
                                    child: Image.network(
                                      orders.mealImage,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(orders.mealName),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text('${orders.quantity}'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }

  @override
  OrdersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrdersViewModel();
}
