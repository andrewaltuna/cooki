import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const _primaryFontFamily = 'Poppins';

  static const _baseTextStyle = TextStyle(
    fontFamily: _primaryFontFamily,
    color: AppColors.fontPrimary,
  );

  // Title
  static final titleLarge = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final titleMedium = _baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final titleSmall = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final titleVerySmall = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // Subtitle
  static final subtitle = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // Body
  static final bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
  );
  static final bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
  );
  static final bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
  );
}
