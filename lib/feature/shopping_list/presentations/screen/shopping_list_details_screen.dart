import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_request_handler.dart';
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
    return ShoppingListRequestHandler(
      shoppingListId: shoppingListId,
      child: const ShoppingListView(),
    );
  }
}
