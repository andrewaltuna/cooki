import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundPrimary,
  canvasColor: AppColors.backgroundPrimary,
  dialogBackgroundColor: AppColors.backgroundPrimary,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.fontPrimary,
    selectionColor: AppColors.accent.withOpacity(0.5),
    selectionHandleColor: AppColors.accent,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: AppColors.dropdownBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: AppColors.dropdownFocusedBorder,
        ),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(
        AppColors.backgroundPrimary,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  ),
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
