part of 'shopping_list_view_model.dart';

class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();
  @override
  List<Object?> get props => [];
}

class ShoppingListRequested extends ShoppingListEvent {
  const ShoppingListRequested({
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  List<Object?> get props => [
        shoppingList,
      ];
}

class ShoppingListUpdated extends ShoppingListEvent {
  const ShoppingListUpdated({
    required this.input,
  });

  final UpdateShoppingListInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}

class ShoppingListDeleted extends ShoppingListEvent {
  const ShoppingListDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}

// Item methods
class ShoppingListItemCreated extends ShoppingListEvent {
  const ShoppingListItemCreated({
    required this.input,
  });

  final CreateShoppingListItemInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}

class ShoppingListItemUpdated extends ShoppingListEvent {
  const ShoppingListItemUpdated({
    required this.input,
  });

  final UpdateShoppingListItemInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}

class ShoppingListItemDeleted extends ShoppingListEvent {
  const ShoppingListItemDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}
