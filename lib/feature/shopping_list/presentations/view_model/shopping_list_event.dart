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
class ShoppingListItemCreated extends ShoppingListEvent {
  const ShoppingListItemCreated({
    required this.input,
  });

  final CreateShoppingListItemInput input;

  @override
  // TODO: implement props
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
