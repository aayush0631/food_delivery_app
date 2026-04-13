import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/utils/error_view.dart';
import 'package:week8/models/order_item.dart';
import 'orders_viewmodel.dart';

class OrdersView extends StackedView<OrdersViewModel> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(OrdersViewModel viewModel) {
    viewModel.fetchOrderedItems();
  }

  @override
  Widget builder(
      BuildContext context, OrdersViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("orders"),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            onPressed: viewModel.toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: viewModel.nav,
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Builder(
        builder: (_) {
          if (viewModel.hasError) {
            return ErrorView(
                message: viewModel.modelError ?? 'Something went wrong');
          }
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.orders.isEmpty) {
            return const Center(child: Text('No orders yet'));
          }
          return OrdersGrid(viewModel: viewModel);
        },
      ),
    );
  }

  @override
  OrdersViewModel viewModelBuilder(BuildContext context) => OrdersViewModel();
}

class OrdersGrid extends StatelessWidget {
  final OrdersViewModel viewModel;
  const OrdersGrid({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.fetchOrderedItems();
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.orders.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final order = viewModel.orders[index];
          return OrderCard(viewModel: viewModel, order: order);
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrdersViewModel viewModel;
  final OrderItem order;

  const OrderCard({super.key, required this.viewModel, required this.order});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          viewModel.navigateToOrderDescription(order);
          viewModel.completeOrder(order);
        },
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: order.id ?? order.hashCode,
                  child: Image.network(
                    order.mealImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(order.mealName),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('${order.quantity}'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  order.status,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
