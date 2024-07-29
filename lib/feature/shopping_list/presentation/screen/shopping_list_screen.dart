import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_view.dart';
import 'package:flutter/widgets.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    return const ShoppingListView();
  }
}
