import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_update_view.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemUpdateScreen extends StatelessWidget {
  const ShoppingListItemUpdateScreen({
    super.key,
    required this.shoppingListItemId,
  });

  final String shoppingListItemId;

  void _listener(
    BuildContext context,
    ShoppingListState state, {
    required String shoppingListId,
  }) {
    if (state.itemStatus.isSuccess) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shoppingListId = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList.id,
    );

    return MainScaffold(
      title: 'Update Item',
      hasBackButton: true,
      body: BlocListener<ShoppingListViewModel, ShoppingListState>(
        listenWhen: (previous, current) =>
            previous.itemStatus != current.itemStatus,
        listener: (context, state) => _listener(
          context,
          state,
          shoppingListId: shoppingListId,
        ),
        child: ShoppingListItemUpdateView(
          shoppingListId: shoppingListId,
          shoppingListItemId: shoppingListItemId,
        ),
      ),
    );
  }
}
