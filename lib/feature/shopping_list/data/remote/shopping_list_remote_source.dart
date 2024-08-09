import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/product/data/remote/product_remote_source.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_gemini_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/create_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_input.dart';
import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/interfered_restrictions_output.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list_item.dart';
import 'package:cooki/feature/shopping_list/data/model/shopping_list.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShoppingListRemoteSource {
  const ShoppingListRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<List<ShoppingList>> getShoppingLists() async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(
          _getShoppingListsQuery,
        ),
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result =
            List<Map<String, dynamic>>.from(data['getAllShoppingListOfUser']);

        return result.map(ShoppingList.fromJson).toList();
      },
    );
  }

  Future<ShoppingList> getShoppingList(String id) async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getShoppingListQuery),
        variables: {
          'id': id,
        },
      ),
    );
    return response.result(
      onSuccess: (data) {
        final result = Map<String, dynamic>.from(data['shoppingList']);

        return ShoppingList.fromJson(result);
      },
    );
  }

  Future<ShoppingList> createGeminiShoppingList(
    CreateGeminiShoppingListInput input,
  ) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_createGeminiShoppingListMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['createGeminiShoppingList'];

        return ShoppingList.fromJson(result);
      },
    );
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

        return ShoppingList.fromJson(result);
      },
    );
  }

  Future<ShoppingList> updateShoppingList(
    UpdateShoppingListInput input,
  ) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_updateShoppingListMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['updateShoppingList'];

        return ShoppingList.fromJson(result);
      },
    );
  }

  Future<void> deleteShoppingList(String id) async {
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
        return;
      },
    );
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
        final result = Map<String, dynamic>.from(data['getShoppingListItem']);

        return ShoppingListItem.fromJson(result);
      },
    );
  }

  Future<ShoppingListItem> updateShoppingListItem(
    UpdateShoppingListItemInput input,
  ) async {
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
        final result = data['updateShoppingListItem'];

        return ShoppingListItem.fromJson(result);
      },
    );
  }

  Future<ShoppingListItem> createShoppingListItem(
    CreateShoppingListItemInput input,
  ) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_createShoppingListItemMutation),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result =
            Map<String, dynamic>.from(data['createShoppingListItem']);

        return ShoppingListItem.fromJson(result);
      },
    );
  }

  Future<void> deleteShoppingListItem(String id) async {
    final response = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(_deleteShoppingListItemMutation),
        variables: {
          'id': id,
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        return;
      },
    );
  }

  Future<InterferedRestrictionsOutput> getInterferedRestrictions(
    String productId,
  ) async {
    final response = await _graphQLClient.query(
      QueryOptions(
        document: gql(_getInterferedRestrictionsQuery),
        variables: {
          'productId': productId,
        },
      ),
    );
    return response.result(
      onSuccess: (data) {
        final result =
            data['getInterferedRestrictions'] as Map<String, dynamic>;

        return InterferedRestrictionsOutput.fromJson(result);
      },
    );
  }
}

const _shoppingListItemOutputFragment = productsOutputFragment +
    r'''
      fragment ShoppingListItemOutputFragment on ItemsOutput {
        _id
        label
        quantity
        isInCart
        product {
          ...ProductsOutputFragment
        }
      }
    ''';

const _shoppingListOutputFragment = _shoppingListItemOutputFragment +
    r'''
      fragment ShoppingListOutputFragment on ShoppingListOutput {
        _id
        name
        userId
        budget
        items {
          ...ShoppingListItemOutputFragment
        }
      }
    ''';

const _getShoppingListsQuery = _shoppingListOutputFragment +
    r'''
      query GetShoppingListsByUser {
        getAllShoppingListOfUser {
          ...ShoppingListOutputFragment
        }
      }
    ''';

const _getShoppingListQuery = _shoppingListOutputFragment +
    r'''
      query GetShoppingList($id: String!) {
        shoppingList(_id: $id) {
          ...ShoppingListOutputFragment
        }
      }
    ''';

const _createGeminiShoppingListMutation = _shoppingListOutputFragment +
    r'''
      mutation createGeminiShoppingList($input: CreateGeminiShoppingListInput!) {
        createGeminiShoppingList(createGeminiShoppingListInput: $input) {
          ...ShoppingListOutputFragment
        }
      }
    ''';

const _createShoppingListMutation = r'''
  mutation CreateShoppingList($input: CreateShoppingListInput!) {
    createShoppingList(createShoppingListInput: $input) {
      _id
      name
      budget
      items {
        _id
      } 
    }
  }
''';

const _updateShoppingListMutation = r'''
  mutation UpdateShoppingList($input: UpdateShoppingListInput!) {
    updateShoppingList(updateShoppingListInput: $input) {
      _id
      name
      budget
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

const _deleteShoppingListMutation = r'''
  mutation DeleteShoppingList($id: String!) {
    removeShoppingList(_id: $id) {
      _id
    }
  }
''';

const _getShoppingListItemQuery = _shoppingListItemOutputFragment +
    r'''
      query GetShoppingListItem($id: String!) {
        getShoppingListItem(_id: $id) {
          ...ShoppingListItemOutputFragment
        }
      }
    ''';

const _updateShoppingListItemMutation = _shoppingListItemOutputFragment +
    r'''
      mutation UpdateShoppingListItem($input: UpdateShoppingListItemInput!) {
        updateShoppingListItem(updateShoppingListItemInput: $input) {
          ...ShoppingListItemOutputFragment
        }
      }
    ''';

const _createShoppingListItemMutation = _shoppingListItemOutputFragment +
    r'''
      mutation CreateShoppingListItem($input: CreateShoppingListItemInput!) {
        createShoppingListItem(createShoppingListItemInput: $input) {
          ...ShoppingListItemOutputFragment
        }
      }
    ''';

const _deleteShoppingListItemMutation = r'''
  mutation DeleteShoppingListItem($id: String!) {
    removeShoppingListItem(_id: $id) {
      _id
    }
  }
''';

const _getInterferedRestrictionsQuery = productsOutputFragment +
    r'''
      query GetInterferedRestrictions($productId: String!) {
        getInterferedRestrictions(productId: $productId) {
          dietaryRestrictions {
            restrictionName
          }
          medications {
            genericName
          }
          alternatives {
            ...ProductsOutputFragment
          }
        }
      }
    ''';
