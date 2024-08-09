import 'dart:ui';

class AppColors {
  const AppColors._();

  // General
  static const primary = Color(0xFF2A2B2E);
  static const secondary = Color(0xFF5A5A66);
  static const accent = Color(0xFF2D6A4F);

  // Background
  static const backgroundPrimary = Color(0xFFF8F9FA);
  static const backgroundSecondary = Color(0xFFDEE2E6);
  static const backgroundTertiary = secondary;
  static const backgroundTextField = backgroundSecondary;

  // Dropdown
  static const dropdownBorder = secondary;
  static const dropdownFocusedBorder = primary;

  // Font
  static const fontPrimary = Color(0xFF212529);
  static const fontSecondary = backgroundPrimary;
  static const fontTertiary = secondary;
  static const fontWarning = Color(0xFFE57373);

  // Shadow
  static const shadow = Color(0x33000000);
  static const shadowSolid = Color(0xFF000000);

  // Badges
  static const badgeCertification = Color(0xFF52B788);
}
