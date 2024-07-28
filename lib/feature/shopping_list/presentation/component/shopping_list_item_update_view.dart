import 'package:collection/collection.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/screen/error_screen.dart';
import 'package:cooki/common/screen/loading_screen.dart';
import 'package:cooki/feature/shopping_list/data/model/input/shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListItemUpdateView extends StatelessWidget {
  const ShoppingListItemUpdateView({
    super.key,
    required this.shoppingListId,
    required this.shoppingListItemId,
  });

  final String shoppingListId;
  final String shoppingListItemId;

  void _onItemDelete(
    BuildContext context,
    String itemId,
  ) {
    {
      // context.read<ShoppingListViewModel>().add(
      //       ShoppingListItemDeleted(
      //         id: itemId,
      //       ),
      //     );
      ShoppingListHelper.of(context).showDeleteShoppingListItemModal(itemId);
    }
  }

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
    return BlocConsumer<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        if (state.updateItemStatus.isSuccess ||
            state.deleteItemStatus.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final status = context.read<ShoppingListViewModel>().state.status;

        final shoppingList =
            context.read<ShoppingListViewModel>().state.shoppingList;

        final shoppingListItem = shoppingList?.items
            .firstWhereOrNull((item) => item.id == shoppingListItemId);

        if (status.isLoading) {
          return const LoadingScreen();
        } else if (status.isError || shoppingListItem == null) {
          return const ErrorScreen(
            errorMessage: 'Not found',
            path: AppRoutes.shoppingLists,
          );
        }

        final formInput = ShoppingListItemInput(
          label: shoppingListItem.label,
          productId: shoppingListItem.product.id,
          quantity: shoppingListItem.quantity,
        );

        return MainScaffold(
          title: "Update Item",
          leading: IconButton(
            onPressed: () {
              context.go(
                '${AppRoutes.shoppingLists}/$shoppingListId',
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => _onItemDelete(
                context,
                shoppingListItemId,
              ),
              icon: Icon(
                Icons.delete,
              ),
            ),
          ],
          body: ShoppingListItemForm(
            initialValue: formInput,
            onSubmit: (formInput) => _onItemUpdate(
              context,
              formInput,
              shoppingListItemId,
            ),
          ),
        );
      },
    );
  }
}
