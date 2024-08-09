import 'package:flutter/material.dart';

class FlexibleText extends StatelessWidget {
  const FlexibleText(
    this.text, {
    required this.style,
    super.key,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            text,
            style: style,
          ),
        ),
      ],
    );
  }
}
