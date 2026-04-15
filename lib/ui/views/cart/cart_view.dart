import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/utils/error_view.dart';
import 'package:week8/ui/views/cart/widgets/grid_view_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Cart"),
      ),
      //order adn delete botton appears only when selection mode
      floatingActionButton: viewModel.isSelectionMode
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  onPressed: viewModel.isBusy
                      ? null
                      : () async {
                          await viewModel.addSelectedToOrders();
                        },
                  icon: viewModel.isBusy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_shopping_cart),
                  label: Text(viewModel.isBusy ? "Adding..." : "Add"),
                ),
                const SizedBox(width: 12), // spacing
                FloatingActionButton.extended(
                  onPressed: viewModel.isBusy
                      ? null
                      : () async {
                          await viewModel.deleteSelectedFromCart();
                        },
                  icon: viewModel.isBusy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.delete),
                  label: Text(viewModel.isBusy ? "Deleting..." : "Delete"),
                ),
              ],
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Builder(
        builder: (_) {
          if (viewModel.hasError) {
            return ErrorView(message: viewModel.modelError!);
          }
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.cart.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }
          return CartGrid(viewModel: viewModel);
        },
      ),
    );
  }

  @override
  CartViewModel viewModelBuilder(BuildContext context) => CartViewModel();
}
