import 'package:cooki/feature/shopping_list/data/model/input/create_gemini_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';

abstract interface class ShoppingListRepositoryInterface {
  Future<List<ShoppingList>> getShoppingLists();
  Future<ShoppingList> getShoppingList(String id);
  Future<ShoppingList> createGeminiShoppingList(
    CreateGeminiShoppingListInput input,
  );
  Future<ShoppingList> createShoppingList(CreateShoppingListInput input);
  Future<ShoppingList> updateShoppingList(UpdateShoppingListInput input);
  Future<ShoppingList> deleteShoppingList(String id);

  // Shopping list item events
  Future<ShoppingListItem> getShoppingListItem(String id);
  Future<ShoppingListItem> createShoppingListItem(
    CreateShoppingListItemInput input,
  );
  Future<ShoppingListItem> updateShoppingListItem(
    UpdateShoppingListItemInput input,
  );
  Future<ShoppingListItem> deleteShoppingListItem(
    String id,
  );
}
