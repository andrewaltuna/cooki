import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_item_view_model.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// TODO: Consolidate with shopping list delete modal
class ShoppingListItemDeleteModal extends StatelessWidget {
  const ShoppingListItemDeleteModal({
    required this.itemId,
  });

  final String itemId;
  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListItemViewModel, ShoppingListItemState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
          context.go(
            Uri(path: '${AppRoutes.shoppingLists}/$itemId').toString(),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Shopping List Item',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Are you sure you want to do this?",
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _onClose(context),
                  child: Text(
                    'Close',
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                TextButton(
                  onPressed: () =>
                      context.read<ShoppingListItemViewModel>().add(
                            ShoppingListItemDeleted(
                              shoppingListId: itemId,
                              id: itemId,
                            ),
                          ),
                  child: Text(
                    'Delete',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
