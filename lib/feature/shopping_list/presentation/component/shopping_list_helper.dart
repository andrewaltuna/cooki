import 'package:cooki/common/helper/dialog_helper.dart';
import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_create_modal.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_update_modal.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListHelper {
  const ShoppingListHelper._(this._context);

  factory ShoppingListHelper.of(BuildContext context) =>
      ShoppingListHelper._(context);

  final BuildContext _context;

  void showCreateShoppingListModal() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<ShoppingListCatalogViewModel>(_context),
              ),
            ],
            child: const Dialog(
              backgroundColor: AppColors.backgroundPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ShoppingListCreateModalContent(),
            ),
          ),
        );
      },
    );
  }

  void showDeleteModal(String shoppingListId) async {
    DialogHelper.of(_context).show(
      DialogArguments(
        title: 'Delete Shopping List',
        message: 'Are you sure you want to do this?',
        confirmText: 'Delete',
        dismissText: 'Cancel',
        onConfirm: () => _context.read<ShoppingListViewModel>().add(
              ShoppingListDeleted(id: shoppingListId),
            ),
      ),
    );
  }

  void showDeleteItemModal(String itemId) async {
    DialogHelper.of(_context).show(
      DialogArguments(
        title: 'Delete Item',
        message: 'Are you sure you want to do this?',
        confirmText: 'Delete',
        dismissText: 'Cancel',
        onConfirm: () => _context.read<ShoppingListViewModel>().add(
              ShoppingListItemDeleted(
                id: itemId,
              ),
            ),
      ),
    );
  }

  void showUpdateModal() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<ShoppingListViewModel>(_context),
              ),
            ],
            child: const Dialog(
              backgroundColor: AppColors.backgroundPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ShoppingListUpdateModalContent(),
            ),
          ),
        );
      },
    );
  }
}
