import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_popup_menu.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_update_handler.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_view.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.select(
      (ShoppingListViewModel viewModel) => viewModel.state.shoppingList,
    );

    return MainScaffold(
      title: shoppingList.name,
      subtitle:
          '${shoppingList.itemsCheckedCount} of ${shoppingList.items.length} items',
      hasBackButton: true,
      actions: [
        ShoppingListPopupMenu(
          parentContext: context,
          shoppingList: shoppingList,
        ),
      ],
      contentPadding: EdgeInsets.zero,
      body: const ShoppingListUpdateHandler(
        child: ShoppingListView(),
      ),
    );
  }
}
