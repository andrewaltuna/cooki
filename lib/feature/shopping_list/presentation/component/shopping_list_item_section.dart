import 'package:cooki/common/component/app_icons.dart';
import 'package:cooki/common/component/button/ink_well_button.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemSection extends StatelessWidget {
  const ShoppingListItemSection({
    super.key,
    required this.shoppingListId,
    required this.category,
    required this.items,
  });

  final String shoppingListId;
  final ProductCategory category;
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
          _CategoryHeader(
            category: category,
            totalPrice: totalPrice,
          ),
          for (final item in items)
            _Item(
              shoppingListId: shoppingListId,
              item: item,
            ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    required this.category,
    required this.totalPrice,
  });

  final ProductCategory category;
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
              SizedBox(
                height: 24,
                width: 24,
                child: category.icon.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                category.displayLabel,
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.fontSecondary,
                ),
              ),
            ],
          ),
          Text(
            'Php ${totalPrice.toStringAsFixed(2)}',
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
          ShoppingListItemUpdated(
            input: UpdateShoppingListItemInput(
              id: item.id,
              isChecked: !item.isChecked,
            ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.label,
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(width: 6),
                Text(
                  '(${item.quantity} x ${item.product.unitSize})',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.fontTertiary,
                  ),
                ),
              ],
            ),
            Text(
              item.product.brand,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.fontTertiary,
              ),
            ),
            Text(
              'Php ${item.product.price}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.fontTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
