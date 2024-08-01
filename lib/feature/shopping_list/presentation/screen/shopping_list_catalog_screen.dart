import 'package:cooki/common/component/main_scaffold.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_catalog_view.dart';
import 'package:flutter/widgets.dart';

class ShoppingListCatalogScreen extends StatelessWidget {
  const ShoppingListCatalogScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: 'Shopping Lists',
      contentPadding: EdgeInsets.zero,
      body: ShoppingListCatalogView(),
    );
  }
}
