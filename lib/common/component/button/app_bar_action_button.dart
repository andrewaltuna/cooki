import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: AppColors.fontPrimary,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 24,
      ),
    );
  }
}
