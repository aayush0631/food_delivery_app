import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:week8/core/utils/error_view.dart';
import 'package:week8/ui/views/cart/widgets/selectino_animation_widget.dart';
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
      floatingActionButton: viewModel.isSelectionMode
          ? FloatingActionButton.extended(
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

class CartGrid extends StatelessWidget {
  final CartViewModel viewModel;
  const CartGrid({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        final isSelected = viewModel.selectedItems.contains(cart);
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            // Start selection mode
            onLongPress: () {
              viewModel.toggleStateOfSelection(cart);
            },
            // Toggle selection if already in selection mode
            onTap: () {
              if (viewModel.isSelectionMode) {
                viewModel.toggleStateOfSelection(cart);
              }
            },
            child: SelectionAnimationWidget(
              isSelected: isSelected,
              cart: cart,
            ),
          ),
        );
      },
    );
  }
}
