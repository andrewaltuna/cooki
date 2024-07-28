import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_create_view.dart';
import 'package:cooki/feature/shopping_list/presentation/component/shopping_list_item_update_view.dart';
import 'package:flutter/widgets.dart';

class ShoppingListItemScreen extends StatelessWidget {
  const ShoppingListItemScreen({
    super.key,
    required this.shoppingListId,
    this.shoppingListItemId,
  });

  final String shoppingListId;
  final String? shoppingListItemId;

  @override
  Widget build(BuildContext context) {
    if (shoppingListItemId == null) {
      return ShoppingListItemCreateView(
        shoppingListId: shoppingListId,
      );
    } else {
      return ShoppingListItemUpdateView(
        shoppingListId: shoppingListId,
        shoppingListItemId: shoppingListItemId!,
      );
    }
  }
}
