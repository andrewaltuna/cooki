import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_section.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_summary.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList,
    );

    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              child: _ShoppingListDetails(
                shoppingList: shoppingList,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ShoppingListSummary(
                totalPrice: shoppingList.totalPrice,
                budget: shoppingList.budget,
              ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: _ShoppingListActions(
            shoppingListId: shoppingList.id,
          ),
        ),
      ],
    );
  }
}

class _ShoppingListDetails extends StatelessWidget {
  const _ShoppingListDetails({
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: shoppingList.itemsBySection.entries
          .map(
            (entry) => ShoppingListItemSection(
              shoppingListId: shoppingList.id,
              section: entry.key,
              items: entry.value,
            ),
          )
          .toList(),
    );
  }
}

class _ShoppingListActions extends StatelessWidget {
  const _ShoppingListActions({
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconButton(
          icon: Icons.add,
          isElevated: true,
          onPressed: () => context.go(
            '${AppRoutes.shoppingLists}/$shoppingListId/create-item',
          ),
        ),
      ],
    );
  }
}
