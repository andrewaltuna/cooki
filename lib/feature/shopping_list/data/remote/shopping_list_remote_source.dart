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
          budget: 980.00,
          items: ShoppingListItemOutput.getDummyItems()),
      ShoppingListOutput(
          id: '2',
          name: 'Weekly Dinner',
          budget: 1023.00,
          items: ShoppingListItemOutput.getDummyItems()),
    ];
  }

  Future<ShoppingListOutput> createShoppingList(
      String name, double budget) async {
    // TODO: Run actual query
    return ShoppingListOutput(
      id: '3',
      name: name,
      budget: budget,
      items: ShoppingListItemOutput.getDummyItems(),
    );
  }

  Future<String> deleteShoppingList(String id) {
    // TODO: Run actual query
    return Future.value(id);
  }
}
