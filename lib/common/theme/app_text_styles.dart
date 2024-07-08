import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const _primaryFontFamily = 'Poppins';
  static const _secondaryFontFamily = 'Roboto';

  static const _primaryFontStyle = TextStyle(
    fontFamily: _primaryFontFamily,
    color: AppColors.fontPrimary,
  );

  static const _secondaryFontStyle = TextStyle(
    fontFamily: _secondaryFontFamily,
    color: AppColors.fontPrimary,
  );

  // Title
  static final titleLarge = _primaryFontStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final titleMedium = _primaryFontStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final titleSmall = _primaryFontStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Body
  static final bodyLarge = _secondaryFontStyle.copyWith(
    fontSize: 16,
  );
  static final bodyMedium = _secondaryFontStyle.copyWith(
    fontSize: 14,
  );
  static final bodySmall = _secondaryFontStyle.copyWith(
    fontSize: 12,
  );
}
