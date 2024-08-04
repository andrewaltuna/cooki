import 'package:cooki/common/helper/dialog_helper.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_create_form.dart';
import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/feature/shopping_list/data/model/chat_shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_update_form.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListHelper {
  const ShoppingListHelper._(this._context);

  factory ShoppingListHelper.of(BuildContext context) =>
      ShoppingListHelper._(context);

  final BuildContext _context;

  void showCreateDialog() {
    DialogHelper.of(_context).showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: true,
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<ShoppingListCatalogViewModel>(_context),
          child: ShoppingListCreateForm(
            onSubmit: (name, budget) =>
                _context.read<ShoppingListCatalogViewModel>().add(
                      ShoppingListCreated(
                        name: name,
                        budget: budget,
                      ),
                    ),
            onSuccess: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(String shoppingListId) async {
    DialogHelper.of(_context).showDefaultDialog(
      DefaultDialogArgs(
        title: 'Delete Shopping List',
        message: 'Are you sure you want to do this?',
        confirmText: 'Delete',
        dismissText: 'Cancel',
        primaryActionType: DefaultDialogAction.warning,
        onConfirm: () => _context.read<ShoppingListViewModel>().add(
              ShoppingListDeleted(id: shoppingListId),
            ),
      ),
    );
  }

  void showDeleteItemDialog(String itemId) async {
    DialogHelper.of(_context).showDefaultDialog(
      DefaultDialogArgs(
        title: 'Delete Item',
        message: 'Are you sure you want to do this?',
        confirmText: 'Delete',
        dismissText: 'Cancel',
        primaryActionType: DefaultDialogAction.warning,
        onConfirm: () => _context.read<ShoppingListViewModel>().add(
              ShoppingListItemDeleted(
                id: itemId,
              ),
            ),
      ),
    );
  }

  void showUpdateDialog() async {
    final shoppingList =
        _context.read<ShoppingListViewModel>().state.shoppingList;

    DialogHelper.of(_context).showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: true,
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<ShoppingListViewModel>(_context),
          child: ShoppingListUpdateForm(
            shoppingListId: shoppingList.id,
            initialName: shoppingList.name,
            initialBudget: shoppingList.budget.toDouble(),
            onSubmit: (name, budget, shoppingListId) =>
                _context.read<ShoppingListViewModel>().add(
                      ShoppingListUpdated(
                        shoppingListId: shoppingListId,
                        name: name,
                        budget: budget,
                      ),
                    ),
            onSuccess: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  void showGeminiCreateDialog(
    List<ChatShoppingListItem> items,
  ) {
    DialogHelper.of(_context).showCustomDialog(
      CustomDialogArgs(
        barrierDismissable: true,
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<ShoppingListCatalogViewModel>(_context),
          child: ShoppingListCreateForm(
            title: 'Convert to Shopping List',
            buttonLabel: 'Convert',
            hasBudgetField: false,
            onSubmit: (name, _) =>
                _context.read<ShoppingListCatalogViewModel>().add(
                      ShoppingListByGeminiCreated(
                        name: name,
                        items: items,
                      ),
                    ),
            onSuccess: () {
              Navigator.pop(context);

              context.go(AppRoutes.shoppingLists);
            },
          ),
        ),
      ),
    );
  }
}
