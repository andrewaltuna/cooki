import 'package:flutter/material.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    this.size = 16,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
