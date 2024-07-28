import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_remote_source.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';

class ShoppingListRepository implements ShoppingListRepositoryInterface {
  const ShoppingListRepository(this._remoteSource);

  final ShoppingListRemoteSource _remoteSource;

  @override
  Future<List<ShoppingList>> getShoppingLists() async {
    return _remoteSource.getShoppingLists();
  }

  @override
  Future<ShoppingList> getShoppingList(String id) {
    return _remoteSource.getShoppingList(id);
  }

  @override
  Future<ShoppingList> createShoppingList(CreateShoppingListInput input) async {
    return _remoteSource.createShoppingList(input);
  }

  @override
  Future<ShoppingList> updateShoppingList(UpdateShoppingListInput input) {
    return _remoteSource.updateShoppingList(input);
  }

  @override
  Future<ShoppingList> deleteShoppingList(String id) async {
    return _remoteSource.deleteShoppingList(id);
  }

  // Item Methods
  @override
  Future<ShoppingListItem> getShoppingListItem(String id) {
    return _remoteSource.getShoppingListItem(id);
  }

  @override
  Future<ShoppingListItem> createShoppingListItem(
    CreateShoppingListItemInput input,
  ) async {
    return _remoteSource.createShoppingListItem(input);
  }

  @override
  Future<ShoppingListItem> updateShoppingListItem(
    UpdateShoppingListItemInput input,
  ) {
    return _remoteSource.updateShoppingListItem(input);
  }

  @override
  Future<ShoppingListItem> deleteShoppingListItem(
    String id,
  ) async {
    return _remoteSource.deleteShoppingListItem(id);
  }
}
