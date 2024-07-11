import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/presentation/component/preferences_selectable_item.dart';
import 'package:flutter/material.dart';

class PreferencesSelectableSection extends StatelessWidget {
  const PreferencesSelectableSection({
    required this.label,
    required this.builder,
    required this.itemCount,
    this.description,
    super.key,
  });

  final String label;
  final String? description;
  final PreferencesSelectableItem Function(int) builder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.titleSmall,
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description ?? '',
            style: AppTextStyles.bodyMedium,
          ),
        ],
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                itemCount,
                (index) => builder(index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
