import 'package:cooki/common/theme/app_colors.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_create_modal_content.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListCreateModal {
  const ShoppingListCreateModal._(this._context);

  factory ShoppingListCreateModal.of(BuildContext context) =>
      ShoppingListCreateModal._(context);

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
                  child: ShoppingListCreateModalContent(),
                ),
              ));
        });
  }
}
