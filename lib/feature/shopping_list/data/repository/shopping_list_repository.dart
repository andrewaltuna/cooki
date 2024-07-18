import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_remote_source.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';

class ShoppingListRepository implements ShoppingListRepositoryInterface {
  const ShoppingListRepository(this._remoteSource);

  final ShoppingListRemoteSource _remoteSource;

  @override
  Future<List<ShoppingListOutput>> getShoppingLists() async {
    return _remoteSource.getShoppingLists();
  }

  @override
  Future<ShoppingListOutput> getShoppingList(String id) {
    return _remoteSource.getShoppingList(id);
  }

  @override
  Future<ShoppingListOutput> createShoppingList(
      String name, double budget) async {
    return _remoteSource.createShoppingList(name, budget);
  }

  @override
  Future<String> deleteShoppingList(String id) async {
    return _remoteSource.deleteShoppingList(id);
  }

  // Item Methods
  @override
  Future<ShoppingListItemOutput> updateShoppingListItem(
      UpdateShoppingListItemInput input) {
    return _remoteSource.updateShoppingListItem(input);
  }
}
