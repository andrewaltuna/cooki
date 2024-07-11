import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_catalog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingListScreen extends HookWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Shopping List',
    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 16),
          const Expanded(
            child: ShoppingListCatalog(),
          ),
          TextButton(onPressed: () => {}, child: const Text('Create List'))
        ],
      )
      );
  }
}