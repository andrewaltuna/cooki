import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_helper/theme/app_color.dart';

class AppTextStyle {
  const AppTextStyle._();

  static final _primaryFont = GoogleFonts.poppins();
  static final _secondaryFont = GoogleFonts.roboto();

  static final TextStyle title = _primaryFont.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColor.fontPrimary,
  );

  static final TextStyle subtitle = _primaryFont.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColor.fontPrimary,
  );

  static final TextStyle body = _secondaryFont.copyWith(
    fontSize: 16,
    color: AppColor.fontPrimary,
  );

  static final TextStyle label = _secondaryFont.copyWith(
    fontSize: 14,
    color: AppColor.fontPrimary,
  );

  static final TextStyle hint = _secondaryFont.copyWith(
    fontSize: 12,
    color: AppColor.fontPrimary,
  );
}
