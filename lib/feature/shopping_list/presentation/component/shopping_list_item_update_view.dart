import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemUpdateView extends StatelessWidget {
  const ShoppingListItemUpdateView({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItemId,
  });

  final String shoppingListId;
  final String shoppingListItemId;

  void _onItemUpdate(
    BuildContext context,
    ShoppingListItemInput formInput,
    String itemId,
  ) {
    final input = UpdateShoppingListItemInput(
      id: itemId,
      label: formInput.label,
      productId: formInput.productId,
      quantity: formInput.quantity,
    );

    context.read<ShoppingListViewModel>().add(
          ShoppingListItemUpdated(
            input: input,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListViewModel, ShoppingListState>(
      builder: (context, state) {
        final shoppingListItem = state.shoppingList.itemById(
          shoppingListItemId,
        );

        final formInput = ShoppingListItemInput(
          label: shoppingListItem.label,
          productId: shoppingListItem.product.id,
          quantity: shoppingListItem.quantity,
        );

        return ShoppingListItemForm(
          initialValue: formInput,
          onSubmit: (formInput) => _onItemUpdate(
            context,
            formInput,
            shoppingListItemId,
          ),
        );
      },
    );
  }
}
