import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  const CustomDropdownMenu({
    required this.entries,
    this.refreshKey,
    this.enabled = true,
    this.controller,
    this.icon,
    this.onSelected,
    this.hintText = 'Select item',
    this.height = 50,
    this.fillColor,
    this.hasBorder = true,
    this.hasShadow = false,
    this.initialSelection,
    super.key,
  });

  final Key? refreshKey;
  final TextEditingController? controller;
  final bool enabled;
  final Widget? icon;
  final void Function(T? value)? onSelected;
  final List<CustomDropdownMenuEntry<T>> entries;
  final T? initialSelection;
  final String hintText;
  final double height;
  final Color? fillColor;
  final bool hasBorder;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme =
        Theme.of(context).dropdownMenuTheme.inputDecorationTheme;
    final noBorder = inputDecorationTheme?.border?.copyWith(
      borderSide: BorderSide.none,
    );

    return Container(
      height: height,
      decoration: hasShadow
          ? const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            )
          : null,
      child: DropdownMenu<T>(
        controller: controller,
        enabled: enabled,
        leadingIcon: icon,
        enableFilter: true,
        requestFocusOnTap: true,
        menuHeight: 200,
        expandedInsets: EdgeInsets.zero,
        textStyle: AppTextStyles.bodyMedium,
        hintText: hintText,
        onSelected: onSelected,
        initialSelection: initialSelection,
        inputDecorationTheme: inputDecorationTheme?.copyWith(
          filled: fillColor != null,
          fillColor: fillColor,
          border: hasBorder ? null : noBorder,
          focusedBorder: hasBorder ? null : noBorder,
        ),
        dropdownMenuEntries: entries
            .map(
              (entry) => DropdownMenuEntry(
                value: entry.value,
                label: entry.label,
                labelWidget: entry.labelWidget,
                style: MenuItemButton.styleFrom(
                  textStyle: AppTextStyles.bodyMedium,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomDropdownMenuEntry<T> {
  const CustomDropdownMenuEntry({
    required this.value,
    this.label = '',
    this.labelWidget,
  });

  final T value;
  final String label;
  final Widget? labelWidget;
}
