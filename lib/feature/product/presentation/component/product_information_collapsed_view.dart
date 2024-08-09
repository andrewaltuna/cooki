import 'package:cooki/common/component/text/flexible_text.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_badge.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:flutter/material.dart';

class ProductInformationCollapsedView extends StatelessWidget {
  const ProductInformationCollapsedView({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlexibleText(
          product.name,
          style: AppTextStyles.titleSmall,
        ),
        FlexibleText(
          product.brand,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.fontTertiary,
          ),
        ),
        Text(
          product.pricePerUnitLabel,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.fontTertiary,
          ),
        ),
        if (product.certifications.isNotEmpty) ...[
          const SizedBox(height: 4),
          CertificationsBadge(
            certificationCount: product.certifications.length,
          ),
        ],
      ],
    );
  }
}
