import 'package:flutter/material.dart';
import 'package:grocery_helper/theme/app_colors.dart';

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
        if (label != null) Text(label ?? ''),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColors.textfieldBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
