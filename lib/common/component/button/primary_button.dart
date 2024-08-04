import 'package:flutter/material.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPress,
    this.width,
    this.height = 44,
    this.prefixIcon,
    this.suffixIcon,
    this.labelColor = AppColors.fontSecondary,
    this.isLoading = false,
    this.backgroundColor = AppColors.accent,
    super.key,
  });

  final String label;
  final VoidCallback onPress;
  final double? width;
  final double height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color labelColor;
  final bool isLoading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: isLoading ? null : onPress,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? LoadingIndicator(
                color: labelColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 4),
                  ],
                  Text(
                    label,
                    style: AppTextStyles.titleVerySmall.copyWith(
                      color: labelColor,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 4),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
