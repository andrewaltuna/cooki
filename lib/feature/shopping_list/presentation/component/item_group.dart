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

class ItemGroup extends StatelessWidget {
  const ItemGroup({
    super.key,
    required this.shoppingListId,
    required this.category,
    required this.items,
  });

  final String shoppingListId;
  final ProductCategory category;
  final List<ShoppingListItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ItemCategory(
          category: category,
        ),
        for (var item in items)
          _ItemDetails(
            shoppingListId: shoppingListId,
            item: item,
          ),
      ],
    );
  }
}

class _ItemCategory extends StatelessWidget {
  const _ItemCategory({
    required this.category,
  });

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.accent,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: category.icon,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            category.displayLabel,
            style: AppTextStyles.titleSmall,
          ),
        ],
      ),
    );
  }
}

class _ItemDetails extends StatelessWidget {
  const _ItemDetails({
    required this.shoppingListId,
    required this.item,
  });

  final String shoppingListId;
  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: _ItemInformation(
            item: item,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.edit,
          ),
          onPressed: () {
            final String path =
                '${AppRoutes.shoppingLists}/$shoppingListId/edit-item/${item.id}';
            context.go(
              Uri(path: path).toString(),
            );
          },
        )
      ],
    );
  }
}

class _ItemInformation extends StatelessWidget {
  const _ItemInformation({
    required this.item,
  });

  final ShoppingListItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: item.isChecked,
          onChanged: (res) {
            context.read<ShoppingListViewModel>().add(
                  ShoppingListItemUpdated(
                    input: UpdateShoppingListItemInput(
                      id: item.id,
                      isChecked: !item.isChecked,
                    ),
                  ),
                );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.label,
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(width: 12),
                Text(
                  '(${item.quantity.toString()} x ${item.product.unitSize})',
                ),
              ],
            ),
            Text(
              'Php ${item.product.price.toString()}',
            ),
          ],
        ),
      ],
    );
  }
}
