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
    required this.shoppingListId,
    required this.formOutput,
  });

  final String shoppingListId;
  final ShoppingListFormOutput formOutput;

  @override
  List<Object?> get props => [
        shoppingListId,
        formOutput,
      ];
}

class ShoppingListItemUpdated extends ShoppingListEvent {
  const ShoppingListItemUpdated({
    required this.itemId,
    required this.formOutput,
  });

  final String itemId;
  final ShoppingListFormOutput formOutput;

  @override
  List<Object?> get props => [
        formOutput,
        itemId,
      ];
}

class ShoppingListItemToggled extends ShoppingListEvent {
  const ShoppingListItemToggled({
    required this.itemId,
    required this.checked,
  });

  final String itemId;
  final bool checked;

  @override
  List<Object?> get props => [
        itemId,
        checked,
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
