import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.color = AppColors.accent,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.iconSize = 24.0,
    this.onPressed,
  });

  final Color color;
  final Color backgroundColor;
  final IconData icon;
  final double iconSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      padding: const EdgeInsets.all(16.0),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
      ),
    );
  }
}
