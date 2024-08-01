part of 'shopping_list_catalog_view_model.dart';

sealed class ShoppingListCatalogEvent extends Equatable {
  const ShoppingListCatalogEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingListCatalogRequested extends ShoppingListCatalogEvent {
  const ShoppingListCatalogRequested();
}

class ShoppingListByGeminiCreated extends ShoppingListCatalogEvent {
  const ShoppingListByGeminiCreated({
    required this.name,
    required this.items,
  });

  final String name;
  final List<ChatShoppingListItem> items;

  @override
  List<Object?> get props => [
        name,
        items,
      ];
}

class ShoppingListCreated extends ShoppingListCatalogEvent {
  const ShoppingListCreated({
    required this.name,
    required this.budget,
  });

  final String name;
  final double budget;

  @override
  List<Object?> get props => [
        name,
        budget,
      ];
}

class ShoppingListEntryUpdated extends ShoppingListCatalogEvent {
  const ShoppingListEntryUpdated({
    required this.updatedShoppingList,
  });

  final ShoppingList updatedShoppingList;

  @override
  List<Object?> get props => [
        updatedShoppingList,
      ];
}

class ShoppingListEntryDeleted extends ShoppingListCatalogEvent {
  const ShoppingListEntryDeleted({
    required this.shoppingListId,
  });

  final String shoppingListId;

  @override
  List<Object?> get props => [
        shoppingListId,
      ];
}
