import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/app/app.locator.dart';
import 'package:week8/repositories/cart_repository.dart';

import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(CartViewModel viewModel) {
    viewModel.fetchCartItems();
  }

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.isBusy) {
      return const CircularProgressIndicator();
    }

    if (viewModel.hasError) {
      return Text(viewModel.modelError.toString());
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: viewModel.cart.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final cart = viewModel.cart[index];

            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      cart.mealImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(cart.mealName),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('$cart.quantity'),
                  ),
                ],
              ),
            );
          },
        ));
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel(locator<CartRepository>());
}
