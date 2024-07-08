import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class AuthRedirectCTA extends StatelessWidget {
  const AuthRedirectCTA({
    required this.description,
    required this.label,
    required this.onPress,
    super.key,
  });

  final String description;
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onPress,
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
