import 'package:flutter/material.dart';
import 'package:week8/models/cart.dart';

class SelectionAnimationWidget extends StatelessWidget {
  const SelectionAnimationWidget({
    super.key,
    required this.isSelected,
    required this.cart,
  });

  final bool isSelected;
  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // animates border change when selection state changes
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        // highlight border when selected
        border: isSelected
            ? Border.all(color: Colors.deepOrange, width: 3)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          AnimatedOpacity(
            // fade effect when item is selected
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 0.5 : 1.0,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // meal image
                  Expanded(
                    child: Image.network(
                      cart.mealImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // meal name
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(cart.mealName),
                  ),
                  // quantity display
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
          // check icon shown only when selected
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: AnimatedScale(
                // smooth pop-in animation for check icon
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
    );
  }
}