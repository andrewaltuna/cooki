import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class MapNearbySectionsIndicator extends StatelessWidget {
  const MapNearbySectionsIndicator({
    required this.sectionLabels,
    required this.onPressed,
    required this.areProductsVisible,
    super.key,
  });

  final List<String> sectionLabels;
  final VoidCallback onPressed;
  final bool areProductsVisible;

  @override
  Widget build(BuildContext context) {
    final hasSections = sectionLabels.isNotEmpty;
    final sectionPrefix = hasSections ? 'You are near:' : 'No nearby sections';
    final icon = switch (hasSections) {
      true => areProductsVisible
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined,
      false => Icons.search_off,
    };

    return InkWellButton(
      circularPadding: 16,
      circularBorderRadius: 12,
      elevation: 3,
      backgroundColor: AppColors.backgroundPrimary,
      onPressed: hasSections ? onPressed : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sectionPrefix,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              if (hasSections)
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sectionLabels
                        .map(
                          (section) => Text(
                            '\u2022 $section',
                            style: AppTextStyles.titleVerySmall,
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
