import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline),
            const SizedBox(width: 8),
            Text(
              errorMessage ?? 'Oops! Something went wrong',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          label: 'Try again',
          style: AppTextStyles.bodyMedium,
          backgroundColor: AppColors.backgroundSecondary,
          onPress: () => onRetry?.call(),
          width: 100,
        ),
      ],
    );
  }
}
