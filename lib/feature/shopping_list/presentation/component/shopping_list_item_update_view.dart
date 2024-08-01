import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_item_form_view_model.dart';
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
    ShoppingListFormOutput formOutput,
    String itemId,
  ) {
    context.read<ShoppingListViewModel>().add(
          ShoppingListItemUpdated(
            itemId: itemId,
            formOutput: formOutput,
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

        return BlocProvider(
          create: (_) => ShoppingListItemFormViewModel()
            ..add(
              ItemFormInitialized(
                shoppingListItem.label,
                shoppingListItem.product.id,
                shoppingListItem.quantity,
              ),
            ),
          child: ShoppingListItemForm(
            onSubmit: (formOutput) => _onItemUpdate(
              context,
              formOutput,
              shoppingListItemId,
            ),
          ),
        );
      },
    );
  }
}
