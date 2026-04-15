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
  //controls the animation progress from 0 to 1 over time
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //syncs animation with screen refresh and pauses when not visible
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    //applies easing curve to make motion smooth instead of linear
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    //starts the animation from 0 to 1
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        //current animation progress value between 0 and 1
        final t = _animation.value;
        //linear interpolation between start and end based on t
        //position = start + (end - start) * t
        final position = Offset.lerp(widget.start, widget.end, t)!;
        double scale;
        if (t < 0.5) {
          scale = 1; //keep full size in first half
        } else {
          //gradually shrink near the end of animation
          scale = 1 - ((t - 0.7) * 2);
        }
        return Positioned(
          //places widget at calculated x and y screen position
          left: position.dx,
          top: position.dy,
          child: Transform.scale(
            //applies scaling transformation to widget
            scale: scale,
            child: ClipRRect(
              //clips child into rounded rectangle shape
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
