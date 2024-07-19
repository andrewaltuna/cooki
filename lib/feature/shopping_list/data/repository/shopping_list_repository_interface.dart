import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';

abstract interface class ShoppingListRepositoryInterface {
  Future<List<ShoppingListOutput>> getShoppingLists();
  Future<ShoppingListOutput> getShoppingList(String id);
  Future<ShoppingListOutput> createShoppingList(CreateShoppingListInput input);
  Future<ShoppingListOutput> deleteShoppingList(String id);

  // Shopping list item events
  Future<ShoppingListItemOutput> createShoppingListItem(
    CreateShoppingListItemInput input,
  );
  Future<ShoppingListItemOutput> updateShoppingListItem(
    UpdateShoppingListItemInput input,
  );
  Future<ShoppingListItemOutput> deleteShoppingListItem(String id);
}
