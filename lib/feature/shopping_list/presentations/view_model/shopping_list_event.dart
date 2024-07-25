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
  List<Object?> get props => [
        id,
      ];
}

class ShoppingListCreated extends ShoppingListEvent {
  const ShoppingListCreated({
    required this.name,
    required this.budget,
  });

  final String name;
  final String budget;

  @override
  List<Object?> get props => [
        name,
        budget,
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
  const ShoppingListDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class ShoppingListItemToggled extends ShoppingListEvent {
  const ShoppingListItemToggled({required this.input});

  final UpdateShoppingListInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}
