import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';

abstract interface class ShoppingListRepositoryInterface {
  Future<List<ShoppingList>> getShoppingLists();
  Future<ShoppingList> getShoppingList(String id);
  Future<ShoppingList> createShoppingList(CreateShoppingListInput input);
  Future<ShoppingList> deleteShoppingList(String id);

  // Shopping list item events
  Future<ShoppingListItem> getShoppingListItem(String id);
  Future<void> createShoppingListItem(
    UpdateShoppingListInput input,
  );
  Future<ShoppingListItem> updateShoppingListItem(
    UpdateShoppingListInput input,
  );
  Future<ShoppingListItem> deleteShoppingListItem(
    UpdateShoppingListInput input,
  );
}
