import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static final _primaryFont = GoogleFonts.poppins();
  static final _secondaryFont = GoogleFonts.roboto();

  static final TextStyle title = _primaryFont.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static final TextStyle subtitle = _primaryFont.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static final TextStyle body = _secondaryFont.copyWith(
    fontSize: 16,
    color: AppColors.fontPrimary,
  );

  static final TextStyle label = _secondaryFont.copyWith(
    fontSize: 14,
    color: AppColors.fontPrimary,
  );

  static final TextStyle hint = _secondaryFont.copyWith(
    fontSize: 12,
    color: AppColors.fontPrimary,
  );
}