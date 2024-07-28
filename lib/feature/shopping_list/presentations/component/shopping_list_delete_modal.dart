import 'package:cooki/common/navigation/app_routes.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingListDeleteModalContent extends StatelessWidget {
  const ShoppingListDeleteModalContent({
    required this.shoppingListId,
  });

  final String shoppingListId;
  void _onClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingListCatalogViewModel, ShoppingListCatalogState>(
      // listenWhen: (previous, current) =>
      //     previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.go(AppRoutes.shoppingLists);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Shopping List',
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
                      context.read<ShoppingListCatalogViewModel>().add(
                            ShoppingListDeleted(
                              id: shoppingListId,
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
