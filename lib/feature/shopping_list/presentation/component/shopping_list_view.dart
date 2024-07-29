import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/component/item_group.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_budget.dart';
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

  void _listener(
    BuildContext context,
    ShoppingListState state,
  ) {
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
  }

  void _onSubmit(
    BuildContext context,
    String id,
  ) {
    ShoppingListHelper.of(context).showDeleteShoppingListModal(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.shoppingList != current.shoppingList ||
          previous.deleteStatus != current.deleteStatus,
      listener: _listener,
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
          ItemGroup(
            shoppingListId: shoppingList.id,
            category: category,
            items: itemsByCategory[category] ?? [],
          ),
        ShoppingListBudget(
          budget: shoppingList.budget,
        ),
      ],
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
