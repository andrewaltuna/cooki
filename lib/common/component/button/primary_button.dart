import 'package:flutter/material.dart';
import 'package:grocery_helper/common/component/indicator/custom_loading_indicator.dart';
import 'package:grocery_helper/common/enum/button_state.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';
import 'package:grocery_helper/common/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPress,
    this.width,
    this.height = 50,
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
        ),
        child: state.isLoading
            ? const CustomLoadingIndicator()
            : Text(
                label,
                style: AppTextStyles.body,
              ),
      ),
    );
  }
}
