import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.select(
      (ShoppingListViewModel viewModel) =>
          viewModel.state.shoppingLists.firstWhere((list) => list.id == id),
    );
    final itemsByCategory = groupBy(shoppingList.items,
        (ShoppingListItemOutput obj) => obj.product.category);

    return MainScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var category in itemsByCategory.keys)
              _ShoppingListCategory(
                  id: shoppingList.id,
                  category: category,
                  items: itemsByCategory[category] ?? [])
            // for (var item in itemsByCategory[category])
            // _ShoppingListItem(
            //   shoppingListId: id,
            //   item: item,
            // )
          ],
        ),
      ),
    );
  }
}

class _ShoppingListCategory extends StatelessWidget {
  const _ShoppingListCategory({
    super.key,
    required this.id,
    required this.category,
    required this.items,
  });

  final String id;
  final ProductCategory category;
  final List<ShoppingListItemOutput> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.apiValue,
        ),
        for (var item in items)
          _ShoppingListItem(
            shoppingListId: id,
            item: item,
          ),
      ],
    );
  }
}

class _ShoppingListItem extends StatelessWidget {
  const _ShoppingListItem(
      {super.key, required this.shoppingListId, required this.item});

  final String shoppingListId;
  final ShoppingListItemOutput item;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: item.isChecked,
          onChanged: (res) {
            context.read<ShoppingListViewModel>().add(
                  ShoppingListItemUpdated(
                    shoppingListId: shoppingListId,
                    input: UpdateShoppingListItemInput(
                      id: item.id,
                      label: item.label,
                      product: item.product,
                      quantity: item.quantity,
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
        )
      ],
    );
  }
}
