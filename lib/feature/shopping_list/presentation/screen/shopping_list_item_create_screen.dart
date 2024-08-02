import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_create_view.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemCreateScreen extends StatelessWidget {
  const ShoppingListItemCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListId = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList.id,
    );

    return MainScaffold(
      title: 'Create Item',
      hasBackButton: true,
      body: ShoppingListItemCreateView(
        shoppingListId: shoppingListId,
      ),
    );
  }
}
