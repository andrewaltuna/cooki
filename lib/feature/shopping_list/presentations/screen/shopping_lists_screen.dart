import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_catalog.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  void _onSubmitted(BuildContext context) {
    ShoppingListHelper.of(context).showCreateShoppingListModal();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Shopping List',
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 16),
            const Expanded(
              child: ShoppingListCatalog(),
            ),
            PrimaryButton(
              label: 'Create List',
              onPress: () => _onSubmitted(context),
            ),
          ],
        ),
      ),
    );
  }
}
