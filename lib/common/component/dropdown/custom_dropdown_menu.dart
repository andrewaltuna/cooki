import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  const CustomDropdownMenu({
    required this.entries,
    this.controller,
    this.icon,
    this.onSelected,
    this.hintText = 'Select item',
    this.height = 50,
    this.fillColor,
    this.hasBorder = true,
    this.initialSelection,
    super.key,
  });

  final TextEditingController? controller;
  final Widget? icon;
  final void Function(T? value)? onSelected;
  final List<CustomDropdownMenuEntry<T>> entries;
  final T? initialSelection;
  final String hintText;
  final double height;
  final Color? fillColor;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme =
        Theme.of(context).dropdownMenuTheme.inputDecorationTheme;
    final noBorder = inputDecorationTheme?.border?.copyWith(
      borderSide: BorderSide.none,
    );

    return SizedBox(
      height: height,
      child: DropdownMenu<T>(
        controller: controller,
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
    required this.label,
  });

  final T value;
  final String label;
}
