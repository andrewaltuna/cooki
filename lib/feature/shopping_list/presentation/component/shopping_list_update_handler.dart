import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListUpdateHandler extends StatelessWidget {
  const ShoppingListUpdateHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  void _updateListener(
    BuildContext context,
    ShoppingListState state,
  ) {
    if (state.updateStatus.isSuccess) {
      context.read<ShoppingListCatalogViewModel>().add(
            ShoppingListEntryUpdated(
              updatedShoppingList: state.shoppingList,
            ),
          );
    }
  }

  void _deleteListener(
    BuildContext context,
    ShoppingListState state,
  ) {
    if (state.deleteStatus.isSuccess) {
      context.read<ShoppingListCatalogViewModel>().add(
            ShoppingListEntryDeleted(
              shoppingListId: state.shoppingList.id,
            ),
          );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShoppingListViewModel, ShoppingListState>(
          listenWhen: (previous, current) =>
              previous.deleteStatus != current.deleteStatus,
          listener: _deleteListener,
        ),
        BlocListener<ShoppingListViewModel, ShoppingListState>(
          listenWhen: (previous, current) =>
              previous.updateStatus != current.updateStatus,
          listener: _updateListener,
        ),
      ],
      child: child,
    );
  }
}
