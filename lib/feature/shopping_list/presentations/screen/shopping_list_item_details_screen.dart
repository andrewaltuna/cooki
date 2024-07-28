import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_item_create_view.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_item_update_view.dart';
import 'package:cooki/feature/shopping_list/presentations/component/shopping_list_request_handler.dart';
import 'package:flutter/widgets.dart';

class ShoppingListItemDetailsScreen extends StatelessWidget {
  const ShoppingListItemDetailsScreen({
    super.key,
    required this.shoppingListId,
    this.shoppingListItemId,
  });

  final String shoppingListId;
  final String? shoppingListItemId;

  @override
  Widget build(BuildContext context) {
    // TODO: Wrap with BlocProvider (ShoppingListViewModel)
    // and conditionally render update or create
    return ShoppingListRequestHandler(
      shoppingListId: shoppingListId,
      child: Builder(
        builder: (context) {
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
        },
      ),
    );
  }
}
