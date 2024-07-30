import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    required this.label,
    this.value,
    this.onChanged,
    super.key,
  });

  final String label;
  final bool? value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium,
          ),
        )
      ],
    );
  }
}
