// import 'package:flutter/material.dart';

// class AnimatedFlyWidget extends StatefulWidget {
//   final Offset start;
//   final Offset end;
//   const AnimatedFlyWidget({super.key,required this.start,required this.end});

//   @override
//   State<AnimatedFlyWidget> createState() => _AniatedFlyWidgetState();
// }

// class _AniatedFlyWidgetState extends State<AnimatedFlyWidget> with SingleTickerProviderStateMixin{
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState(){
//     super.initState();
//     _controller=AnimationController(vsync: this,duration:const Duration(milliseconds: 600));
//     _animation = Tween<Offset>(begin: widget.start,end: widget.end).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose() ;
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Positioned(
//           left: _animation.value.dx,
//           top: _animation.value.dy,
//           child: const Icon(
//             Icons.fastfood,
//             size: 30,
//             color: Colors.orange,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

class AnimatedFlyWidget extends StatefulWidget {
  final Offset start;
  final Offset end;
  final String image;
  final Size size;

  const AnimatedFlyWidget({
    super.key,
    required this.start,
    required this.end,
    required this.image, 
    required this.size,
  });

  @override
  State<AnimatedFlyWidget> createState() => _AnimatedFlyWidgetState();
}

class _AnimatedFlyWidgetState extends State<AnimatedFlyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();
  }
    @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value;

        final position = Offset.lerp(widget.start, widget.end, t)!;

        // 🔥 SCALE LOGIC (IMPORTANT)
        double scale;

        if (t < 0.7) {
          scale = 1; // stay full size
        } else {
          // shrink only at end
          scale = 1 - ((t - 0.7) * 2); 
        }

        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Transform.scale(
            scale: scale.clamp(0.3, 1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.image,
                width: widget.size.width,
                height: widget.size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
