import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundPrimary,
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent;
        }

        return Colors.transparent;
      },
    ),
    overlayColor: WidgetStateProperty.all(
      AppColors.accent.withOpacity(0.3),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    side: BorderSide(
      width: 1.5,
      color: AppColors.fontPrimary.withOpacity(0.5),
    ),
  ),
);
