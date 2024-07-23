import 'package:cooki/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_item_delete_modal.dart';

class ShoppingListItemHelper {
  const ShoppingListItemHelper._(this._context);

  factory ShoppingListItemHelper.of(BuildContext context) =>
      ShoppingListItemHelper._(context);

  final BuildContext _context;

  void showDeleteShoppingListItemModal(String itemId) async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: AppColors.backgroundPrimary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16,
                ),
              ),
            ),
            child: ShoppingListItemDeleteModal(
              itemId: itemId,
            ),
          ),
        );
      },
    );
  }
}
