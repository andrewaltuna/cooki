import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_view.dart';
import 'package:flutter/widgets.dart';

class ShoppingListDetailsScreen extends StatelessWidget {
  const ShoppingListDetailsScreen({
    super.key,
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  Widget build(BuildContext context) {
    return const ShoppingListView();
  }
}
