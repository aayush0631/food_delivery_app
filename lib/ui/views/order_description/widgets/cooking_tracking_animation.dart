import 'package:flutter/material.dart';
import 'package:week8/models/order_item.dart';

class CookingAnimation extends StatefulWidget {
  final OrderItem order;
  const CookingAnimation({super.key, required this.order});

  @override
  State<CookingAnimation> createState() => _CookingAnimationState();
}

class _CookingAnimationState extends State<CookingAnimation> {
  bool isCooked = false;   // becomes true after animation ends
  int rating = 0;          // user rating (1–5)
  bool showRating = false; // controls rating UI visibility

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 10),

      // animation runs from 0 → 10
      tween: Tween(begin: 0, end: 10),

      onEnd: () {
        // cooking finished
        setState(() {
          isCooked = true;
        });

        // show rating after delay
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            showRating = true;
          });
        });
      },

      builder: (context, value, child) {
        // value = current animation value (0 → 10)
        // convert to 0 → 1 for progress bar
        final progress = value / 10;

        return Column(
          children: [
            // image fades in gradually
            AnimatedOpacity(
              opacity: isCooked ? 0 : progress,
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
                    // icon grows when cooking is done
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

                    // text changes after cooking
                    Text(
                      isCooked
                          ? "${widget.order.mealName} is ready 🎉"
                          : "Cooking ${widget.order.mealName}...",
                    ),

                    const SizedBox(height: 20),

                    // progress bar uses normalized value (0–1)
                    SizedBox(
                      width: 300,
                      child: LinearProgressIndicator(value: progress),
                    ),

                    const SizedBox(height: 20),

                    // text fades in gradually
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

            // rating UI appears after cooking
            if (showRating) ...[
              const SizedBox(height: 30),

              const Text(
                "Rate your experience",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = index + 1; // set rating
                      });
                    },
                    child: AnimatedScale(
                      // enlarge selected stars
                      scale: rating > index ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.star,
                        size: 35,
                        color: rating > index
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              Text(
                rating == 0
                    ? "Tap to rate"
                    : "You rated $rating ⭐",
                style: const TextStyle(fontSize: 16),
              ),
            ]
          ],
        );
      },
    );
  }
}