import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
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
