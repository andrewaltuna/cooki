part of 'shopping_list_view_model.dart';

sealed class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingListsRequested extends ShoppingListEvent {
  const ShoppingListsRequested();
}

class ShoppingListRequested extends ShoppingListEvent {
  const ShoppingListRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class ShoppingListCreated extends ShoppingListEvent {
  const ShoppingListCreated({required this.name, required this.budget});

  final String name;
  final String budget;

  @override
  List<Object?> get props => [name];
}

class ShoppingListUpdated extends ShoppingListEvent {
  const ShoppingListUpdated(
      {required this.id, required this.name, required this.budget});

  final String id;
  final String name;
  final String budget;
}

class ShoppingListDeleted extends ShoppingListEvent {
  const ShoppingListDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

// Shopping List Item Events
class ShoppingListItemUpdated extends ShoppingListEvent {
  const ShoppingListItemUpdated({
    required this.shoppingListId,
    required this.input,
  });

  final String shoppingListId;
  final UpdateShoppingListItemInput input;

// TODO: Hook up edit for checking + adding of items
  @override
  List<Object?> get props => [
        shoppingListId,
        input,
      ];
}
