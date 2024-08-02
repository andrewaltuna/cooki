import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_update_view.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemUpdateScreen extends StatelessWidget {
  const ShoppingListItemUpdateScreen({
    super.key,
    required this.shoppingListItemId,
  });

  final String shoppingListItemId;

  @override
  Widget build(BuildContext context) {
    final shoppingListId = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList.id,
    );

    return MainScaffold(
      title: 'Update Item',
      hasBackButton: true,
      body: ShoppingListItemUpdateView(
        shoppingListId: shoppingListId,
        shoppingListItemId: shoppingListItemId,
      ),
    );
  }
}
