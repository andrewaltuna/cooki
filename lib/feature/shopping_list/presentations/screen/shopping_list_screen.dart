import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShoppingListScreen extends HookWidget {
  const ShoppingListScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    useOnWidgetLoad(() {
      context.read<ShoppingListViewModel>().add(
            ShoppingListRequested(id),
          );
    });

    final (
      isFetching,
      shoppingList,
    ) = context.select(
      (ShoppingListViewModel viewModel) => (
        viewModel.state.status,
        viewModel.state.selectedShoppingList,
      ),
    );

    print('Shopping list ${shoppingList}');

    // TODO: Use isInitialLoading (already takes this into account)
    if (isFetching.isLoading && shoppingList == null) {
      return const Center(
        child: Text("Fetching..."),
      );
    } else if (shoppingList == null) {
      return const Center(
        child: Text("Not found"),
      );
    }

    final itemsByCategory = groupBy(
        shoppingList.items, (ShoppingListItem obj) => obj.product.category);

    return MainScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                TextButton(
                  child: Text(
                    'Go Back',
                  ),
                  onPressed: () {
                    context
                        .read<ShoppingListViewModel>()
                        .add(const ShoppingListsRequested());

                    context.go(
                      Uri(
                        path: AppRoutes.shoppingLists,
                      ).toString(),
                    );
                  },
                ),
                for (var category in itemsByCategory.keys)
                  _ShoppingListCategory(
                    id: shoppingList.id,
                    category: category,
                    items: itemsByCategory[category] ?? [],
                  ),
              ],
            ),
            TextButton(
              onPressed: () => context.go(
                Uri(
                  path: '${AppRoutes.shoppingLists}/$id/create-item',
                ).toString(),
              ),
              child: Text(
                'Create Item',
              ),
            ),
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
  final List<ShoppingListItem> items;

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
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.edit,
          ),
          onPressed: () => context.go(
            Uri(path: '${AppRoutes.shoppingLists}/$shoppingListId/edit-item/${item.id}')
                .toString(),
          ),
        )
      ],
    );
  }
}
