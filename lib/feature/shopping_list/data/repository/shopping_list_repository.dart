import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_remote_source.dart';
import 'package:cooki/feature/shopping_list/data/repository/shopping_list_repository_interface.dart';

class ShoppingListRepository implements ShoppingListRepositoryInterface {
  const ShoppingListRepository(this._remoteSource);

  final ShoppingListRemoteSource _remoteSource;

  @override
  Future<List<ShoppingListOutput>> getShoppingLists() {
    return _remoteSource.getShoppingLists();
  }

  @override
  Future<ShoppingListOutput> createShoppingList(String name) {
    return _remoteSource.createShoppingList(name);
  }
}
