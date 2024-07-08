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
    this.state = ButtonState.idle,
    super.key,
  });

  final String label;
  final VoidCallback onPress;
  final double? width;
  final double height;
  final ButtonState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.accent,
          padding: EdgeInsets.zero,
        ),
        child: state.isLoading
            ? const LoadingIndicator()
            : Text(
                label,
                style: AppTextStyles.bodyMedium,
              ),
      ),
    );
  }
}
