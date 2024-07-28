import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_create_modal.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_delete_modal.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
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

  void showDeleteShoppingListModal(String shoppingListId) async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        print('BUILDING DIALOG');
        return PopScope(
          canPop: false,
          child: BlocProvider.value(
            value: BlocProvider.of<ShoppingListViewModel>(_context),
            child: Dialog(
              backgroundColor: AppColors.backgroundPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ShoppingListDeleteModalContent(
                shoppingListId: shoppingListId,
              ),
            ),
          ),
        );
      },
    );
  }
}
