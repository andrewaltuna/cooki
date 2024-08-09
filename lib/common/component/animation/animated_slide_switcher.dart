import 'package:flutter/material.dart';

class AnimatedSlideSwitcher extends StatelessWidget {
  const AnimatedSlideSwitcher({
    required this.beginOffsetDy,
    required this.durationInMs,
    this.child,
    super.key,
  });

  final double beginOffsetDy;
  final int durationInMs;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: Duration(milliseconds: durationInMs),
      reverseDuration: Duration(milliseconds: durationInMs),
      transitionBuilder: (child, animation) {
        final position = Tween<Offset>(
          begin: Offset(0, beginOffsetDy),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: position,
          child: child,
        );
      },
      child: child,
    );
  }
}
