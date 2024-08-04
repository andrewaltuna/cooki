import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_restrictions.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemView extends StatelessWidget {
  const ShoppingListItemView({
    super.key,
    required this.itemId,
  });

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final item = context.select(
      (ShoppingListViewModel viewModel) =>
          viewModel.state.shoppingList.itemById(itemId),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _InformationRow(
            icon: const Icon(Icons.edit_outlined),
            label: 'Label',
            description: item.label,
          ),
          const Divider(),
          _InformationRow(
            icon: const Icon(Icons.label_outline),
            label: 'Product',
            description: item.product.brand,
          ),
          const Divider(),
          _InformationRow(
            icon: const Icon(Icons.numbers),
            label: 'Quantity',
            description: item.quantity.toString(),
          ),
          const SizedBox(height: 16),
          ShoppingListItemRestrictions(
            itemId: itemId,
            productId: item.product.id,
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  const _InformationRow({
    required this.icon,
    required this.label,
    required this.description,
  });

  final Widget icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.titleSmall,
              ),
              Text(
                description,
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
