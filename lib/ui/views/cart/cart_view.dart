import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (viewModel.cart.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Cart is empty")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
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
          final isSelected = viewModel.selectedItems.contains(cart);

          return GestureDetector(
            onLongPress: () {
              viewModel.toggleStateOfSelection(cart);
            },
            onTap: () {
              if (viewModel.isSelectionMode) {
                viewModel.toggleStateOfSelection(cart);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: Colors.deepOrange, width: 3)
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isSelected ? 0.85 : 1.0,
                    child: Card(
                      margin: EdgeInsets.zero,
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
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('${cart.quantity}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: AnimatedScale(
                        scale: isSelected ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.elasticOut,
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 28,
                        ),
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
  CartViewModel viewModelBuilder(BuildContext context) => CartViewModel();
}
