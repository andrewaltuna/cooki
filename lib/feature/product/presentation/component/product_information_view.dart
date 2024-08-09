import 'package:cooki/common/component/text/flexible_text.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_page_view.dart';
import 'package:cooki/feature/product/presentation/component/product_image_view.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:flutter/material.dart';

class ProductInformationView extends StatelessWidget {
  const ProductInformationView({
    required this.product,
    this.quantity,
    super.key,
  });

  final Product product;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    final hasCertifications = product.certifications.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final imageSize = constraints.maxWidth * 0.33;

            return Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: ProductImageView(
                    imageUrl: product.imageUrl,
                    height: imageSize,
                    width: imageSize,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
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
                      const SizedBox(height: 4),
                      if (quantity != null)
                        Text(
                          'Quantity: $quantity',
                          style: AppTextStyles.bodyMedium,
                        ),
                      Text(
                        product.sectionLabel,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.fontTertiary,
                        ),
                      ),
                      Text(
                        product.pricePerUnitLabel,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.fontTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Description',
          style: AppTextStyles.titleVerySmall,
        ),
        Text(
          product.description,
          style: AppTextStyles.bodyMedium,
        ),
        if (hasCertifications) ...[
          const SizedBox(height: 16),
          Text(
            'Eco-badges (${product.certifications.length})',
            style: AppTextStyles.titleVerySmall,
          ),
          const SizedBox(height: 6),
          Flexible(
            child: CertificationsPageView(
              isElevated: true,
              isDense: true,
              certifications: product.certifications,
            ),
          ),
        ],
      ],
    );
  }
}
