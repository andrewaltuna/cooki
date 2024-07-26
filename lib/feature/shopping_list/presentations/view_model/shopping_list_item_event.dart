part of 'shopping_list_item_view_model.dart';

sealed class ShoppingListItemEvent extends Equatable {
  const ShoppingListItemEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingListItemRequested extends ShoppingListItemEvent {
  const ShoppingListItemRequested({
    required this.shoppingListItemId,
  });

  final String shoppingListItemId;

  @override
  List<Object?> get props => [
        shoppingListItemId,
      ];
}

class ShoppingListItemCreated extends ShoppingListItemEvent {
  const ShoppingListItemCreated({
    required this.input,
  });

  final CreateShoppingListItemInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}

class ShoppingListItemUpdated extends ShoppingListItemEvent {
  const ShoppingListItemUpdated({
    required this.input,
  });

  final UpdateShoppingListItemInput input;

  @override
  List<Object?> get props => [
        input,
      ];
}

class ShoppingListItemDeleted extends ShoppingListItemEvent {
  const ShoppingListItemDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}
