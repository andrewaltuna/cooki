import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_catalog.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_helper.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_catalog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListsScreen extends HookWidget {
  const ShoppingListsScreen({super.key});

  void _onSubmitted(BuildContext context) {
    ShoppingListHelper.of(context).showCreateShoppingListModal();
  }

  @override
  Widget build(BuildContext context) {
    // useOnWidgetLoad(() {
    //   context.read<ShoppingListViewModel>().add(const ShoppingListsRequested());
    // });

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
