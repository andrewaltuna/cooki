import 'package:cooki/common/extension/graphql_extensions.dart';
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
    final response = await _graphQLClient
        .query(QueryOptions(document: gql(_getShoppingListsQuery)));

    response.result(onSuccess: (data) {
      // TODO: Return this
    });
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
  Future<ShoppingListItem> getShoppingListItem(String id) async {
    final item =
        dummyData.shoppingListItems.firstWhere((item) => item.id == id);
    return _transformShoppingListItemData(item);
  }

  Future<ShoppingListItem> updateShoppingListItem(
      UpdateShoppingListItemInput input) async {
    final updatedItem = RawShoppingListItem(
      id: input.id,
      label: input.label,
      quantity: input.quantity,
      isChecked: input.isChecked,
      productId: input.productId,
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
    dummyData.shoppingLists = dummyData.shoppingLists.map((list) {
      if (list.id == input.shoppingListId) {
        return RawShoppingList(
            id: list.id,
            name: list.name,
            budget: list.budget,
            itemIds: list.itemIds + [newShoppingListItem.id]);
      } else {
        return list;
      }
    }).toList();

    return _transformShoppingListItemData(newShoppingListItem);
  }

  Future<ShoppingListItem> deleteShoppingListItem(
      String shoppingListId, String id) async {
    final deletedShoppingListItem = dummyData.shoppingListItems.firstWhere(
      (item) => item.id == id,
    );
    dummyData.shoppingListItems = dummyData.shoppingListItems
        .where(
          (item) => item.id != id,
        )
        .toList();

    dummyData.shoppingLists = dummyData.shoppingLists.map((list) {
      if (list.id == shoppingListId) {
        return RawShoppingList(
          id: list.id,
          name: list.name,
          budget: list.budget,
          itemIds: list.itemIds
              .where((itemId) => itemId != deletedShoppingListItem.id)
              .toList(),
        );
      } else {
        return list;
      }
    }).toList();

    return _transformShoppingListItemData(deletedShoppingListItem);
  }
}

const _getShoppingListsQuery = r'''
query GetShoppingLists {
  shoppingLists {
    _id
    name
    userId
    description
    items {
      _id
    }
  }
}
''';

const _getShoppingListQuery = r'''
  query GetShoppingList($id: String!) {
    shoppingList(id: $id) {
      _id
      name
      description
      items {
        _id
        label
        quantity
        isChecked
        product {
          _id
          brand
          category
          price
          section
          unitSize
        }
      }
    }
  }
''';

const _createShoppingListMutation = r'''
  mutation CreateShoppingList($input: CreateShoppingListInput!) {
    createShoppingList(createShoppingListInput: $input) {
      _id
      name
      description
      items {
        _id
      } 
    }
  }
''';

const _deleteShoppingListMutation = r'''
  mutation DeleteShoppingList($id: String!) {
    deleteShoppingList(id: $id) {
      _id
    }
  }
''';

const _getShoppingListItemQuery = r'''
  query GetShoppingListItem($id: String!) {
    shoppingListItem(id: $id) {
      _id
      label
      quantity
      isChecked
      product {
        _id
        brand
        category
        price
        section
        unitSize
      }
    }
  }
''';

const _updateShoppingListItemMutation = r'''
  mutation UpdateShoppingListItem($input: UpdateShoppingListItemInput!) {
    updateShoppingListItem(updateShoppingListItemInput: $input) {
      _id
      label
      quantity
      isChecked
      product {
        _id
        brand
        category
        price
        section
        unitSize
      }
    }
  }
''';

const _createShoppingListItemMutation = r'''
  mutation CreateShoppingListItem($input: CreateShoppingListItemInput!) {
    createShoppingListItem(createShoppingListItemInput: $input) {
      _id
      label
      quantity
      isChecked
      product {
        _id
        brand
        category
        price
        section
        unitSize
      }
    }
  }
''';

const _deleteShoppingListItemMutation = r'''
  mutation DeleteShoppingListItem($shoppingListId: String!, $id: String!) {
    deleteShoppingListItem(shoppingListId: $shoppingListId, id: $id) {
      _id
    }
  }
''';
