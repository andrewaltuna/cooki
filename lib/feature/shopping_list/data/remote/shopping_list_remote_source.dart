import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/product/data/model/output/product_output.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:cooki/feature/shopping_list/data/remote/shopping_list_dummy_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShoppingListRemoteSource {
  const ShoppingListRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  // ProductOutput _transformProductData(RawProduct product) {
  //   return ProductOutput(
  //     id: product.id,
  //     brand: product.brand,
  //     category: product.category,
  //     description: product.description,
  //     keyIngredients: product.keyIngredients,
  //     price: product.price,
  //     section: product.section,
  //     unitSize: product.unitSize,
  //   );
  // }

  // ShoppingListItem _transformShoppingListItemData(RawShoppingListItem item) {
  //   final rawProduct = dummyData.products
  //       .firstWhere((product) => item.productId == product.id);
  //   return ShoppingListItem(
  //     id: item.id,
  //     isChecked: item.isChecked,
  //     label: item.label,
  //     quantity: item.quantity,
  //     product: _transformProductData(rawProduct),
  //   );
  // }

  // ShoppingListOutput _transformShoppingListData(RawShoppingList shoppingList) {
  //   return ShoppingListOutput(
  //     id: shoppingList.id,
  //     budget: shoppingList.budget,
  //     name: shoppingList.name,
  //     items: shoppingList.itemIds
  //         .map(
  //           (id) => dummyData.shoppingListItems.firstWhere(
  //             (item) => item.id == id,
  //           ),
  //         )
  //         .map(
  //           (item) => _transformShoppingListItemData(
  //             item,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  Future<List<ShoppingList>> getShoppingLists() async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(
          _getShoppingListsQuery,
        ),
      ),
    );

    return response.result(onSuccess: (data) {
      final result = new List<Map<String, dynamic>>.from(data['shoppingLists']);

      final shoppingListData = result.map(ShoppingList.fromJson).toList();
      return shoppingListData;
    });
    // final shoppingListData = dummyData.shoppingLists;

    // return shoppingListData
    //     .map(
    //       (list) => _transformShoppingListData(list),
    //     )
    //     .toList();
  }

  Future<ShoppingList> getShoppingList(String id) async {
    final response = await this._graphQLClient.query(
          QueryOptions(
            document: gql(_getShoppingListQuery),
            variables: {
              'id': id,
            },
          ),
        );
    return response.result(
      onSuccess: (data) {
        final result = new Map<String, dynamic>.from(data['shoppingList']);
        final shoppingListData = ShoppingList.fromJson(result);
        return shoppingListData;
      },
    );

    // final shoppingListData =
    //     dummyData.shoppingLists.firstWhere((list) => list.id == id);
    // return _transformShoppingListData(shoppingListData);
  }

  Future<ShoppingList> createShoppingList(
    CreateShoppingListInput input,
  ) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_createShoppingListMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['createShoppingList'];
        final shoppingListData = ShoppingList.fromJson(result);
        return shoppingListData;
      },
    );

    // final newShoppingList = RawShoppingList(
    //   id: (dummyData.shoppingLists.length + 1).toString(),
    //   name: input.name,
    //   budget: input.budget,
    //   itemIds: [],
    // );

    // dummyData.shoppingLists.add(newShoppingList);

    // return _transformShoppingListData(newShoppingList);
  }

  Future<ShoppingList> deleteShoppingList(String id) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_deleteShoppingListMutation),
        variables: {
          'id': id,
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['deleteShoppingList'];
        final shoppingListData = ShoppingList.fromJson(result);
        return shoppingListData;
      },
    );
    // final deletedShoppingList =
    //     dummyData.shoppingLists.firstWhere((list) => list.id == id);
    // dummyData.shoppingLists =
    //     dummyData.shoppingLists.where((list) => list.id != id).toList();
    // return _transformShoppingListData(deletedShoppingList);
  }

  // Item queries
  Future<ShoppingListItem> getShoppingListItem(String id) async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getShoppingListItemQuery),
        variables: {
          'id': id,
        },
      ),
    );
    return response.result(
      onSuccess: (data) {
        final result = new Map<String, dynamic>.from(data['shoppingListItem']);
        final shoppingListItemData = ShoppingListItem.fromJson(result);
        return shoppingListItemData;
      },
    );
    // final item =
    //     dummyData.shoppingListItems.firstWhere((item) => item.id == id);
    // return _transformShoppingListItemData(item);
  }

  Future<ShoppingListItem> updateShoppingListItem(
      UpdateShoppingListInput input) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_updateShoppingListItemMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['updateShoppingList'];
        final shoppingListItemData = ShoppingListItem.fromJson(result);
        return shoppingListItemData;
      },
    );
    // final updatedItem = RawShoppingListItem(
    //   id: input.id,
    //   label: input.label,
    //   quantity: input.quantity,
    //   isChecked: input.isChecked,
    //   productId: input.productId,
    // );

    // dummyData.shoppingListItems = dummyData.shoppingListItems
    //     .map((item) => item.id == input.id ? updatedItem : item)
    //     .toList();

    // final productData = dummyData.products
    //     .firstWhere((product) => product.id == updatedItem.productId);

    // return ShoppingListItem(
    //   id: updatedItem.id,
    //   label: updatedItem.label,
    //   quantity: updatedItem.quantity,
    //   isChecked: updatedItem.isChecked,
    //   product: _transformProductData(productData),
    // );
  }

  Future<void> createShoppingListItem(
    UpdateShoppingListInput input,
  ) async {
    print('INPUT ${input.toJson()}');
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_createShoppingListItemMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    // return response.result(onSuccess: (data) {
    //   final result = data['createShoppingList'];
    //   final shoppingListItemData = ShoppingListItem.fromJson(result);
    //   return shoppingListItemData;
    // });

    // final newShoppingListItem = RawShoppingListItem(
    //   id: (dummyData.shoppingListItems.length + 1).toString(),
    //   label: input.label,
    //   quantity: input.quantity,
    //   isChecked: false,
    //   productId: input.productId,
    // );

    // dummyData.shoppingListItems.add(newShoppingListItem);
    // dummyData.shoppingLists = dummyData.shoppingLists.map((list) {
    //   if (list.id == input.shoppingListId) {
    //     return RawShoppingList(
    //         id: list.id,
    //         name: list.name,
    //         budget: list.budget,
    //         itemIds: list.itemIds + [newShoppingListItem.id]);
    //   } else {
    //     return list;
    //   }
    // }).toList();

    // return _transformShoppingListItemData(newShoppingListItem);
  }

  Future<ShoppingListItem> deleteShoppingListItem(
      UpdateShoppingListInput input) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_deleteShoppingListItemMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(onSuccess: (data) {
      final result = data['deleteShoppingList'];
      final shoppingListItemData = ShoppingListItem.fromJson(result);
      return shoppingListItemData;
    });
    // final deletedShoppingListItem = dummyData.shoppingListItems.firstWhere(
    //   (item) => item.id == id,
    // );
    // dummyData.shoppingListItems = dummyData.shoppingListItems
    //     .where(
    //       (item) => item.id != id,
    //     )
    //     .toList();

    // dummyData.shoppingLists = dummyData.shoppingLists.map((list) {
    //   if (list.id == shoppingListId) {
    //     return RawShoppingList(
    //       id: list.id,
    //       name: list.name,
    //       budget: list.budget,
    //       itemIds: list.itemIds
    //           .where((itemId) => itemId != deletedShoppingListItem.id)
    //           .toList(),
    //     );
    //   } else {
    //     return list;
    //   }
    // }).toList();

    // return _transformShoppingListItemData(deletedShoppingListItem);
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
      label
    }
  }
}
''';

const _getShoppingListQuery = r'''
  query GetShoppingList($id: String!) {
    shoppingList(_id: $id) {
      _id
      name
      description
      items {
        _id
        label
        quantity
        isInCart
        product {
          _id
          brand
          productCategory
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
    removeShoppingList(_id: $id) {
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
      isInCart
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

// TODO: Update to match BE (just use updateShoppingList)
const _updateShoppingListItemMutation = r'''
  mutation UpdateShoppingListItem($input: UpdateShoppingListInput!) {
    updateShoppingList(updateShoppingListInput: $input) {
      _id
    }
  }
''';

const _createShoppingListItemMutation = r'''
  mutation CreateShoppingListItem($input: UpdateShoppingListInput!) {
    updateShoppingList(updateShoppingListInput: $input) {
      _id
    }
  }
''';

const _deleteShoppingListItemMutation = r'''
  mutation DeleteShoppingListItem($input: UpdateShoppingListInput!) {
    updateShoppingListInput(updateShoppingListInput: $input) {
      _id
    }
  }
''';
