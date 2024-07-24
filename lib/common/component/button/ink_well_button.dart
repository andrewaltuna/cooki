import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  const InkWellButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.circularBorderRadius = 0,
    this.circularPadding = 0,
    super.key,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final double circularBorderRadius;
  final double circularPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(circularBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(circularBorderRadius),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(circularPadding),
          child: child,
        ),
      ),
    );
  }
}
