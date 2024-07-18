import 'package:cooki/feature/shopping_list/data/model/input/update_shopping_list_item_input.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_item_output.dart';
import 'package:cooki/feature/shopping_list/data/model/output/shopping_list_output.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final List<ShoppingListOutput> dummyData = <ShoppingListOutput>[
  ShoppingListOutput(
    id: '1',
    name: 'Weekly Groceries',
    budget: 980.00,
    items: ShoppingListItemOutput.getDummyItems(),
  ),
  ShoppingListOutput(
    id: '2',
    name: 'Weekly Dinner',
    budget: 1023.00,
    items: ShoppingListItemOutput.getDummyItems(),
  ),
  // ShoppingListOutput(
  //   id: '3',
  //   name: 'Birthday',
  //   budget: 4025.00,
  //   items: ShoppingListItemOutput.getDummyItems(),
  // ),
];

class ShoppingListRemoteSource {
  const ShoppingListRemoteSource(this._graphQLClient);

  final GraphQLClient _graphQLClient;

  Future<List<ShoppingListOutput>> getShoppingLists() async {
    // TODO: Run actual query
    return dummyData;
  }

  Future<ShoppingListOutput> getShoppingList(String id) async {
    return dummyData.firstWhere((element) => element.id == id);
  }

  Future<ShoppingListOutput> createShoppingList(
      String name, double budget) async {
    // TODO: Run actual query
    final newList = ShoppingListOutput(
      id: dummyData.length.toString(),
      name: name,
      budget: budget,
      items: ShoppingListItemOutput.getDummyItems(),
    );

    dummyData.add(newList);
    return newList;
  }

  Future<String> deleteShoppingList(String id) {
    // TODO: Run actual query
    dummyData.removeWhere((element) => element.id == id);
    return Future.value(id);
  }

  // Item queries
  Future<ShoppingListItemOutput> updateShoppingListItem(
      UpdateShoppingListItemInput input) {
    // TODO: Run query

    return Future.value(
      ShoppingListItemOutput.fromJson(
        input.toJson(),
      ),
    );
  }
}
