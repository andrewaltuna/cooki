import 'package:flutter/material.dart';
import 'package:grocery_helper/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPress,
    this.width,
    this.height = 50,
    super.key,
  });

  final String label;
  final VoidCallback onPress;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          // TODO: set color
          backgroundColor: AppColors.accent,
        ),
        child: Text(label),
      ),
    );
  }
}
