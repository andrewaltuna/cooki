import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/chat/presentation/component/certifications_badge.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemSection extends StatelessWidget {
  const ShoppingListItemSection({
    super.key,
    required this.shoppingListId,
    required this.section,
    required this.items,
  });

  final String shoppingListId;
  final String section;
  final List<ShoppingListItem> items;

  num _computeTotalPrice(List<ShoppingListItem> items) {
    return items
        .map((item) => item.product.price * item.quantity)
        .reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    final num totalPrice = _computeTotalPrice(items);

    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            section: section,
            totalPrice: totalPrice,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) => _Item(
              shoppingListId: shoppingListId,
              item: items[index],
            ),
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: items.length,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.section,
    required this.totalPrice,
  });

  final String section;
  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accent,
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.storage_rounded,
                color: AppColors.fontSecondary,
                size: 24,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                section,
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
            ],
          ),
          Text(
            'USD ${totalPrice.toStringAsFixed(2)}',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.fontSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.shoppingListId,
    required this.item,
  });

  final String shoppingListId;
  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      backgroundColor: Colors.transparent,
      onPressed: () => context.go(
        '${AppRoutes.shoppingLists}/$shoppingListId/item/${item.id}',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: _ItemDetails(item: item),
      ),
    );
  }
}

class _ItemDetails extends StatelessWidget {
  const _ItemDetails({
    required this.item,
  });

  final ShoppingListItem item;

  void _onToggled(BuildContext context) {
    context.read<ShoppingListViewModel>().add(
          ShoppingListItemToggled(
            itemId: item.id,
            checked: !item.isChecked,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: item.isChecked,
          onChanged: (_) => _onToggled(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      item.product.name,
                      style: AppTextStyles.titleSmall,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(${item.product.unitSize} x ${item.quantity})',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.fontTertiary,
                    ),
                  ),
                ],
              ),
              Text(
                item.product.brand,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.fontTertiary,
                ),
              ),
              Text(
                'USD ${item.product.price}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.fontTertiary,
                ),
              ),
              if (item.product.certifications.isNotEmpty) ...[
                const SizedBox(height: 4),
                CertificationsBadge(
                  certificationCount: item.product.certifications.length,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
