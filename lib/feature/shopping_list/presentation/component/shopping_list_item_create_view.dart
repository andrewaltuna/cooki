import 'package:cooki/feature/shopping_list/data/model/shopping_list_item_form_output.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_item_form/shopping_list_item_form_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemCreateView extends StatelessWidget {
  const ShoppingListItemCreateView({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  void _onItemCreate(
    BuildContext context,
    ShoppingListItemFormOutput formOutput,
    String shoppingListId,
  ) {
    context.read<ShoppingListViewModel>().add(
          ShoppingListItemCreated(
            shoppingListId: shoppingListId,
            formOutput: formOutput,
          ),
        );
  }

  void _listener(
    BuildContext context,
    ShoppingListState state,
  ) {
    if (state.itemStatus.isSuccess) {
      context.read<ShoppingListCatalogViewModel>().add(
            ShoppingListEntryUpdated(
              updatedShoppingList: state.shoppingList,
            ),
          );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.itemStatus != current.itemStatus,
      listener: _listener,
      child: BlocProvider(
        create: (_) =>
            ShoppingListItemFormViewModel()..add(const ItemFormInitialized()),
        child: ShoppingListItemForm(
          onSubmit: (formOutput) => _onItemCreate(
            context,
            formOutput,
            shoppingListId,
          ),
        ),
      ),
    );
  }
}
