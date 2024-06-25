import 'package:flutter/material.dart';
import 'package:grocery_helper/theme/app_text_style.dart';

class AuthRedirectCTA extends StatelessWidget {
  const AuthRedirectCTA({
    required this.description,
    required this.label,
    required this.onPress,
    super.key,
  });

  final String description;
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          description,
          style: AppTextStyle.label,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onPress,
          child: Text(
            label,
            style: AppTextStyle.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
