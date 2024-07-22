import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
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
      CreateShoppingListInput input) async {
    return _remoteSource.createShoppingList(input);
  }

  @override
  Future<ShoppingListOutput> deleteShoppingList(String id) async {
    return _remoteSource.deleteShoppingList(id);
  }

  // Item Methods
  @override
  Future<ShoppingListItem> createShoppingListItem(
      CreateShoppingListItemInput input) async {
    return _remoteSource.createShoppingListItem(input);
  }

  @override
  Future<ShoppingListItem> updateShoppingListItem(
      UpdateShoppingListItemInput input) {
    return _remoteSource.updateShoppingListItem(input);
  }

  @override
  Future<ShoppingListItem> deleteShoppingListItem(
      String shoppingListId, String id) async {
    return _remoteSource.deleteShoppingListItem(shoppingListId, id);
  }
}
