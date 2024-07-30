import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
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
    ShoppingListItemInput formInput,
    String shoppingListId,
  ) {
    final input = CreateShoppingListItemInput(
      shoppingListId: shoppingListId,
      label: formInput.label,
      productId: formInput.productId,
      quantity: formInput.quantity,
    );

    context.read<ShoppingListViewModel>().add(
          ShoppingListItemCreated(
            input: input,
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
    const formInput = ShoppingListItemInput(
      label: '',
      productId: '',
      quantity: 0,
    );

    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listenWhen: (previous, current) =>
          previous.itemStatus != current.itemStatus,
      listener: _listener,
      child: ShoppingListItemForm(
        initialValue: formInput,
        onSubmit: (formValues) => _onItemCreate(
          context,
          formValues,
          shoppingListId,
        ),
      ),
    );
  }
}
