import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PreferencesSelectableItem extends StatelessWidget {
  const PreferencesSelectableItem({
    required this.label,
    required this.icon,
    required this.onSelected,
    this.isSelected = false,
    super.key,
  });

  final bool isSelected;
  final String label;
  final Widget icon;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.backgroundSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
              width: 16,
              child: icon,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
