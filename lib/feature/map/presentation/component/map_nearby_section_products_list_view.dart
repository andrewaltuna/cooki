import 'package:cooki/common/component/animation/animated_slide_switcher.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_badge.dart';
import 'package:cooki/feature/product/presentation/component/product_image_view.dart';
import 'package:cooki/feature/product/data/model/product.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:flutter/material.dart';

class MapNearbySectionProductsView extends StatelessWidget {
  const MapNearbySectionProductsView({
    required this.visible,
    required this.products,
    super.key,
  });

  final bool visible;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlideSwitcher(
      beginOffsetDy: 1,
      durationInMs: 100,
      child: visible && products.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 115,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final isLastItem = index == products.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(right: isLastItem ? 0 : 8),
                      child: _ProductView(
                        product: products[index],
                      ),
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      onPressed: () =>
          ShoppingListHelper.of(context).showProductInformationDialog(
        product,
      ),
      width: 300,
      circularPadding: 16,
      circularBorderRadius: 16,
      elevation: 3,
      backgroundColor: AppColors.backgroundPrimary,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: AspectRatio(
              aspectRatio: 1,
              child: ProductImageView(
                imageUrl: product.imageUrl,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleVerySmall,
                ),
                Text(
                  product.brand,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                if (product.certifications.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  CertificationsBadge(
                    certificationCount: product.certifications.length,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
