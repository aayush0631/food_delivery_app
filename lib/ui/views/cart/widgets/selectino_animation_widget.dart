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
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border:
            isSelected ? Border.all(color: Colors.deepOrange, width: 3) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            // turn light when selected
            opacity: isSelected ? 0.5 : 1.0,
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
          // creates circular tick button
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
    );
  }
}
