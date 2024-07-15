import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';

abstract interface class ShoppingListRepositoryInterface {
  Future<List<ShoppingListOutput>> getShoppingLists();
  Future<ShoppingListOutput> createShoppingList(String name, double budget);
  Future<String> deleteShoppingList(String id);
}
