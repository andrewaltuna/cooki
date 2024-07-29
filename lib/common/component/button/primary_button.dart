import 'package:flutter/material.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/enum/button_state.dart';
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
    this.style,
    this.state = ButtonState.idle,
    this.bgColor = AppColors.accent,
    super.key,
  });

  final String label;
  final VoidCallback onPress;
  final double? width;
  final double height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final ButtonState state;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.zero,
        ),
        child: state.isLoading
            ? const LoadingIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    const SizedBox(width: 4),
                    prefixIcon!,
                  ],
                  Text(
                    label,
                    style: style ??
                        AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.fontSecondary,
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
