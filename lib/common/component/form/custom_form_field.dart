import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    this.controller,
    this.label,
    this.hintText,
    this.initialText,
    this.errorText,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autovalidateMode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? initialText;
  final String? errorText;
  final IconData? icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label ?? '',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 3),
        ],
        TextFormField(
          initialValue: initialText,
          autovalidateMode: autovalidateMode,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          style: AppTextStyles.bodyMedium,
          inputFormatters: inputFormatters,
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
