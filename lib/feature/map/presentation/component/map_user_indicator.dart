import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MapUserIndicator extends HookWidget {
  const MapUserIndicator({
    required this.size,
    required this.inverseScale,
    super.key,
  });

  final double size;
  final double inverseScale;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat();

    // Pulsing animation
    final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    final fadeAnimation = Tween<double>(begin: 1, end: 0).animate(controller);

    final indicatorSize = size * inverseScale;
    final indicatorBorderWidth = 2 * inverseScale;
    final pulseSize = indicatorSize * 5;

    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: pulseSize,
              height: pulseSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
            ),
          ),
        ),
        Container(
          height: indicatorSize,
          width: indicatorSize,
          decoration: BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: indicatorBorderWidth,
            ),
          ),
        ),
      ],
    );
  }
}
