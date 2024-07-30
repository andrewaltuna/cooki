import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListItemDeleteModal extends HookWidget {
  const ShoppingListItemDeleteModal({
    super.key,
    required this.itemId,
  });

  final String itemId;

  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListViewModel, ShoppingListState>(
      listener: (context, state) {
        if (state.deleteItemStatus.isSuccess) {
          Navigator.pop(context);
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
                  child: const Text(
                    'Close',
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                TextButton(
                  onPressed: () => context.read<ShoppingListViewModel>().add(
                        ShoppingListItemDeleted(
                          id: itemId,
                        ),
                      ),
                  child: const Text(
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
