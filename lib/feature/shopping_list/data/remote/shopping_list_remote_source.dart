import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShoppingListRemoteSource {
  const ShoppingListRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<List<ShoppingListOutput>> getShoppingLists() async {
    // TODO: Run actual query
    return <ShoppingListOutput>[
      ShoppingListOutput(
          id: '1',
          name: 'Weekly Groceries',
          items: ShoppingListItemOutput.getDummyItems()),
      ShoppingListOutput(
          id: '2',
          name: 'Weekly Dinner',
          items: ShoppingListItemOutput.getDummyItems()),
    ];
  }

  Future<ShoppingListOutput> createShoppingList(String name) async {
    // TODO: Run actual query
    return ShoppingListOutput(
        id: '3', name: name, items: ShoppingListItemOutput.getDummyItems());
  }
}
