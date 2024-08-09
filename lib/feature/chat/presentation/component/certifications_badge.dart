import 'package:cooki/common/component/app_icons.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CertificationsBadge extends StatelessWidget {
  const CertificationsBadge({
    required this.certificationCount,
    super.key,
  });

  final int certificationCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.badgeCertification,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcons.certifications.copyWith(
            color: AppColors.fontSecondary,
            height: 12,
          ),
          const SizedBox(width: 4),
          Text(
            'Eco-badges ($certificationCount)',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.fontSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
