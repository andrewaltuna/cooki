import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/preferences/data/enum/product_category.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({
    super.key,
  });

  void _onSubmit(
    BuildContext context,
    String id,
  ) {
    ShoppingListHelper.of(context).showDeleteShoppingListModal(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        context.read<ShoppingListCatalogViewModel>().add(
              ShoppingListEntryUpdated(
                updatedShoppingList: state.shoppingList!,
              ),
            );

        if (state.deleteStatus.isSuccess) {
          context.read<ShoppingListCatalogViewModel>().add(
                ShoppingListEntryDeleted(
                  shoppingListId: state.shoppingList!.id,
                ),
              );
          Navigator.of(context).pop();
          context.go(AppRoutes.shoppingLists);
        }
      },
      builder: (context, state) {
        final shoppingList = state.shoppingList;
        final isFetching = state.isInitialLoading;

        if (isFetching) {
          return const LoadingScreen();
        } else if (shoppingList == null) {
          return const ErrorScreen(
            errorMessage: 'Not found',
            path: AppRoutes.shoppingLists,
          );
        }
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
              onPressed: () => _onSubmit(
                context,
                shoppingList.id,
              ),
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
          contentPadding: EdgeInsets.zero,
          body: _ShoppingListContent(
            shoppingList: shoppingList,
          ),
        );
      },
    );
  }
}

class _ShoppingListContent extends StatelessWidget {
  const _ShoppingListContent({
    super.key,
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ShoppingListDetails(
            shoppingList: shoppingList,
          ),
          const Spacer(),
          _ShoppingListActions(
            shoppingListId: shoppingList.id,
          ),
        ],
      ),
    );
  }
}

class _ShoppingListDetails extends StatelessWidget {
  const _ShoppingListDetails({
    super.key,
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    final itemsByCategory = groupBy(
        shoppingList.items, (ShoppingListItem obj) => obj.product.category);

    return Column(
      children: [
        for (final category in itemsByCategory.keys)
          _ItemGroup(
            shoppingListId: shoppingList.id,
            category: category,
            items: itemsByCategory[category] ?? [],
          ),
        _ShoppingListBudget(
          budget: shoppingList.budget,
        ),
      ],
    );
  }
}

class _ItemGroup extends StatelessWidget {
  const _ItemGroup({
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
    super.key,
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
    super.key,
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
          icon: Icon(
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
    super.key,
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

class _ShoppingListBudget extends StatelessWidget {
  const _ShoppingListBudget({
    super.key,
    required this.budget,
  });

  final num budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundSecondary,
      padding: const EdgeInsets.all(
        12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [
            Icon(
              Icons.monetization_on,
              size: 24,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Total",
            ),
          ]),
          Text(
            'Php ${budget.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

class _ShoppingListActions extends StatelessWidget {
  const _ShoppingListActions({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: AppColors.accent,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.backgroundSecondary,
          ),
          padding: const EdgeInsets.all(
            16.0,
          ),
          onPressed: () => context.go(
            '${AppRoutes.shoppingLists}/$shoppingListId/create-item',
          ),
          icon: Icon(
            Icons.add,
            size: 24.0,
          ),
        ),
      ],
    );
  }
}
