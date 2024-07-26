import 'package:flutter/material.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.errorText,
    this.icon,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.fillColor = AppColors.backgroundTextField,
    this.inputBorder,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autovalidateMode,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final String? errorText;
  final IconData? icon;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final Color? fillColor;
  final InputBorder? inputBorder;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    const defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    );

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
          controller: controller,
          focusNode: focusNode,
          minLines: minLines,
          maxLines: maxLines,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
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
            filled: fillColor != null,
            fillColor: fillColor,
            border: inputBorder ?? defaultInputBorder,
            focusedBorder: inputBorder ?? defaultInputBorder,
            enabledBorder: inputBorder ?? defaultInputBorder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
