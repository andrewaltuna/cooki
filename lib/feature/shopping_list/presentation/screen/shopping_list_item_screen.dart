import 'package:cooki/common/component/button/app_bar_action_button.dart';
import 'package:cooki/common/component/button/custom_icon_button.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_view.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemScreen extends StatelessWidget {
  const ShoppingListItemScreen({
    super.key,
    required this.shoppingListItemId,
  });

  final String shoppingListItemId;

  void _listener(
    BuildContext context,
    ShoppingListState state,
  ) {
    if (state.deleteItemStatus.isSuccess || state.updateItemStatus.isSuccess) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shoppingListId = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList.id,
    );

    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.deleteItemStatus != current.deleteItemStatus ||
          previous.updateItemStatus != current.updateItemStatus,
      listener: _listener,
      child: MainScaffold(
        title: 'Item Details',
        hasBackButton: true,
        actions: [
          AppBarActionButton(
            icon: Icons.delete_outline,
            onPressed: () =>
                ShoppingListHelper.of(context).showDeleteItemDialog(
              shoppingListItemId,
            ),
          ),
        ],
        contentPadding: EdgeInsets.zero,
        body: Stack(
          children: [
            Positioned.fill(
              child: ShoppingListItemView(
                itemId: shoppingListItemId,
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: CustomIconButton(
                icon: Icons.edit,
                isElevated: true,
                onPressed: () => context.go(
                  '${AppRoutes.shoppingLists}/$shoppingListId/item/$shoppingListItemId/edit-item',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
