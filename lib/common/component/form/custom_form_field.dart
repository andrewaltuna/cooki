import 'package:flutter/material.dart';
import 'package:grocery_helper/common/theme/app_colors.dart';
import 'package:grocery_helper/common/theme/app_text_styles.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    this.controller,
    this.label,
    this.hintText,
    this.errorText,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final IconData? icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label ?? '',
            style: AppTextStyles.label,
          ),
          const SizedBox(height: 3),
        ],
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hintText ?? 'Aa',
            errorText: errorText,
            prefixIcon: icon != null ? Icon(icon, size: 15) : null,
            filled: true,
            fillColor: AppColors.backgroundTextField,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}
