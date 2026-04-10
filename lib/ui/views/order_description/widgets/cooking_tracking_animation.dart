import 'package:flutter/material.dart';
import 'package:week8/models/order_item.dart';

class CookingAnimation extends StatefulWidget {
  final OrderItem order;
  const CookingAnimation({super.key, required this.order});
  @override
  State<CookingAnimation> createState() => _CookingAnimationState();
}

class _CookingAnimationState extends State<CookingAnimation> {
  bool isCooked = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 10),
      tween: Tween(begin: 0, end: 10),
      onEnd: () {
        setState(() {
          isCooked = true;
        });
      },
      builder: (context, value, child) {
        final progress = value / 10;
        return Column(
          children: [
            AnimatedOpacity(
              opacity: isCooked? 0 :progress, 
              duration: const Duration(milliseconds: 300),
              child: Hero(
              tag: widget.order.id!,
              child: Image.network(
                widget.order.mealImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isCooked ? 1.5 : 1,
                      duration: const Duration(milliseconds: 500),
                      child: Icon(
                        isCooked ? Icons.celebration : Icons.restaurant,
                        color: isCooked ? Colors.orange : Colors.green,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isCooked
                          ? "${widget.order.mealName} is ready 🎉"
                          : "Cooking ${widget.order.mealName}...",
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300, 
                      child: LinearProgressIndicator(value: progress),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: isCooked ? 1 : (0.5 + 0.5 * progress),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        isCooked ? "Enjoy your meal!" : "Preparing food...",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
