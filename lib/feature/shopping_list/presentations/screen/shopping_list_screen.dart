import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/common/hook/use_on_widget_load.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_catalog.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_create_helper.dart';
import 'package:cooki/feature/shopping_list/presentations/view_model/shopping_list_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListScreen extends HookWidget {
  const ShoppingListScreen({super.key});

  void _onSubmitted(BuildContext context) {
    ShoppingListCreateModal.of(context).showCreateShoppingListModal();
  }

  @override
  Widget build(BuildContext context) {
    useOnWidgetLoad(() {
      final testVar = context.read<ShoppingListViewModel>().state.shoppingLists;
      print(testVar);
    });

    return MainScaffold(
        title: 'Shopping List',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 16),
            const Expanded(
              child: ShoppingListCatalog(),
            ),
            TextButton(
              onPressed: () => _onSubmitted(context),
              child: const Text('Create List'),
            ),
          ],
        ));
  }
}
