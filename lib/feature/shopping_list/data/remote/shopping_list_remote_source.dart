import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_dummy_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShoppingListRemoteSource {
  const ShoppingListRemoteSource(this._graphQLClient);

  // TODO: Run actual queries
  final GraphQLClient _graphQLClient;

  ProductOutput _transformProductData(RawProduct product) {
    return ProductOutput(
      id: product.id,
      brand: product.brand,
      category: product.category,
      description: product.description,
      keyIngredients: product.keyIngredients,
      price: product.price,
      section: product.section,
      unitSize: product.unitSize,
    );
  }

  ShoppingListItem _transformShoppingListItemData(RawShoppingListItem item) {
    final rawProduct = dummyData.products
        .firstWhere((product) => item.productId == product.id);
    return ShoppingListItem(
      id: item.id,
      isChecked: item.isChecked,
      label: item.label,
      quantity: item.quantity,
      product: _transformProductData(rawProduct),
    );
  }

  ShoppingListOutput _transformShoppingListData(RawShoppingList shoppingList) {
    return ShoppingListOutput(
      id: shoppingList.id,
      budget: shoppingList.budget,
      name: shoppingList.name,
      items: shoppingList.itemIds
          .map(
            (id) => dummyData.shoppingListItems.firstWhere(
              (item) => item.id == id,
            ),
          )
          .map(
            (item) => _transformShoppingListItemData(
              item,
            ),
          )
          .toList(),
    );
  }

  Future<List<ShoppingListOutput>> getShoppingLists() async {
    final shoppingListData = dummyData.shoppingLists;

    return shoppingListData
        .map(
          (list) => _transformShoppingListData(list),
        )
        .toList();
  }

  Future<ShoppingListOutput> getShoppingList(String id) async {
    final shoppingListData =
        dummyData.shoppingLists.firstWhere((list) => list.id == id);
    return _transformShoppingListData(shoppingListData);
  }

  Future<ShoppingListOutput> createShoppingList(
      CreateShoppingListInput input) async {
    final newShoppingList = RawShoppingList(
      id: (dummyData.shoppingLists.length + 1).toString(),
      name: input.name,
      budget: input.budget,
      itemIds: [],
    );

    dummyData.shoppingLists.add(newShoppingList);

    return _transformShoppingListData(newShoppingList);
  }

  Future<ShoppingListOutput> deleteShoppingList(String id) async {
    final deletedShoppingList =
        dummyData.shoppingLists.firstWhere((list) => list.id == id);
    dummyData.shoppingLists =
        dummyData.shoppingLists.where((list) => list.id != id).toList();
    return _transformShoppingListData(deletedShoppingList);
  }

  // Item queries
  Future<ShoppingListItem> updateShoppingListItem(
      UpdateShoppingListItemInput input) async {
    final updatedItem = RawShoppingListItem(
      id: input.id,
      label: input.label,
      quantity: input.quantity,
      isChecked: input.isChecked,
      productId: input.product.id,
    );

    dummyData.shoppingListItems = dummyData.shoppingListItems
        .map((item) => item.id == input.id ? updatedItem : item)
        .toList();

    final productData = dummyData.products
        .firstWhere((product) => product.id == updatedItem.productId);

    return ShoppingListItem(
      id: updatedItem.id,
      label: updatedItem.label,
      quantity: updatedItem.quantity,
      isChecked: updatedItem.isChecked,
      product: _transformProductData(productData),
    );
  }

  Future<ShoppingListItem> createShoppingListItem(
      CreateShoppingListItemInput input) async {
    final newShoppingListItem = RawShoppingListItem(
      id: (dummyData.shoppingListItems.length + 1).toString(),
      label: input.label,
      quantity: input.quantity,
      isChecked: false,
      productId: input.productId,
    );

    dummyData.shoppingListItems.add(newShoppingListItem);

    return _transformShoppingListItemData(newShoppingListItem);
  }

  Future<ShoppingListItem> deleteShoppingListItem(String id) async {
    final deletedShoppingListItem = dummyData.shoppingListItems.firstWhere(
      (item) => item.id == id,
    );
    dummyData.shoppingListItems = dummyData.shoppingListItems
        .where(
          (item) => item.id != id,
        )
        .toList();
    return _transformShoppingListItemData(deletedShoppingListItem);
  }
}
