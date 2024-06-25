import 'package:flutter/material.dart';
import 'package:grocery_helper/theme/app_color.dart';
import 'package:grocery_helper/theme/app_text_style.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    this.controller,
    this.label,
    this.hintText,
    this.obscureText = false,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label ?? '',
            style: AppTextStyle.label,
          ),
          const SizedBox(height: 3),
        ],
        TextFormField(
          obscureText: obscureText,
          style: AppTextStyle.body,
          decoration: InputDecoration(
            hintText: hintText ?? 'Aa',
            filled: true,
            fillColor: AppColor.textfieldBackground,
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
