import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  const InkWellButton({
    required this.child,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.circularBorderRadius = 0,
    this.circularPadding = 0,
    this.elevation = 0,
    super.key,
  });

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final double circularBorderRadius;
  final double circularPadding;
  final double elevation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        shadowColor: AppColors.shadowSolid,
        borderRadius: BorderRadius.circular(circularBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(circularBorderRadius),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(circularPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
