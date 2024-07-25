import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/extension/enum_extension.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
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

    // TODO: Use isInitialLoading (already takes this into account)
    if (isFetching.isLoading && shoppingList == null) {
      return LoadingScreen();
    } else if (shoppingList == null) {
      return ErrorScreen(
        errorMessage: 'Not found',
        path: Uri(
          path: AppRoutes.shoppingLists,
        ).toString(),
      );
    }

    final itemsByCategory = groupBy(
        shoppingList.items, (ShoppingListItem obj) => obj.product.category);

    return MainScaffold(
      title: shoppingList.name,
      leading: IconButton(
        onPressed: () {
          context.go(
            Uri(
              path: AppRoutes.shoppingLists,
            ).toString(),
          );
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Redirect to lists page after deletion
            context.read<ShoppingListViewModel>().add(ShoppingListDeleted(id));
          },
          icon: const Icon(Icons.delete),
        ),
      ],
      contentPadding: EdgeInsets.zero,
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  for (var category in itemsByCategory.keys)
                    _ShoppingListCategory(
                      shoppingList: shoppingList,
                      category: category,
                      items: itemsByCategory[category] ?? [],
                    ),
                  Container(
                    width: double.infinity,
                    color: AppColors.backgroundSecondary,
                    padding: EdgeInsets.all(
                      12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.monetization_on,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text("Total"),
                        ]),
                        Text(
                          'Php ${shoppingList.budget.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(
                color: AppColors.accent,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.backgroundSecondary,
                ),
                padding: const EdgeInsets.all(
                  16.0,
                ),
                onPressed: () => context.go(
                  Uri(
                    path: '${AppRoutes.shoppingLists}/$id/create-item',
                  ).toString(),
                ),
                icon: Icon(
                  Icons.add,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShoppingListCategory extends StatelessWidget {
  const _ShoppingListCategory({
    super.key,
    required this.shoppingList,
    required this.category,
    required this.items,
  });

  final ShoppingList shoppingList;
  final ProductCategory category;
  final List<ShoppingListItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
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
                category.apiValue,
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
        ),
        for (var item in items)
          _ShoppingListItem(
            shoppingList: shoppingList,
            item: item,
          ),
      ],
    );
  }
}

class _ShoppingListItem extends StatelessWidget {
  const _ShoppingListItem({
    super.key,
    required this.shoppingList,
    required this.item,
  });

  final ShoppingList shoppingList;
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
          child: Row(
            children: [
              Checkbox(
                value: item.isChecked,
                onChanged: (res) {
                  context.read<ShoppingListViewModel>().add(
                        ShoppingListItemToggled(
                            input: UpdateShoppingListInput(
                                id: shoppingList.id,
                                items: [
                              ...shoppingList.items
                                  .where((element) => element.id != item.id)
                                  .map(
                                    (e) => e.toInput(),
                                  ),
                              item
                                  .copyWith(isChecked: !item.isChecked)
                                  .toInput(),
                            ])),
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
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.edit,
          ),
          onPressed: () {
            final String path =
                '${AppRoutes.shoppingLists}/${shoppingList.id}/edit-item/${item.id}';
            context.go(
              Uri(path: path).toString(),
            );
          },
        )
      ],
    );
  }
}
