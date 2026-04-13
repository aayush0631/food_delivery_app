import 'package:flutter/material.dart';

class RatingAnimation extends StatefulWidget {
  final bool isfilled;

  const RatingAnimation({super.key, required this.isfilled});
  @override
  State<RatingAnimation> createState() => RatingAnimationState();
}

class RatingAnimationState extends State<RatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int rating = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.6).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap() {
    if (rating < 5) {
      setState(() {
        rating++;
      });
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Icon(
                  Icons.star,
                  color: rating < 4 ? Colors.green : Colors.yellow,
                  size: 40,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Text(
            rating.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
