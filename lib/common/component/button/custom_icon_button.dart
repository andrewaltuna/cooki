import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.color = AppColors.backgroundSecondary,
    this.backgroundColor = AppColors.accent,
    this.iconSize = 24.0,
    this.padding = 16.0,
    this.size,
    this.isLoading = false,
    this.onPressed,
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final double iconSize;
  final double padding;
  final double? size;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(
        color: color,
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
        ),
        padding: EdgeInsets.all(padding),
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? LoadingIndicator(
                color: color,
              )
            : Icon(
                icon,
                size: iconSize,
              ),
      ),
    );
  }
}
