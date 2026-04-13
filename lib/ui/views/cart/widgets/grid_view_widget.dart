import 'package:flutter/material.dart';
import 'package:week8/ui/views/cart/cart_viewmodel.dart';
import 'package:week8/ui/views/cart/widgets/selectino_animation_widget.dart';

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