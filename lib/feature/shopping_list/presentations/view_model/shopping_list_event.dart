part of 'shopping_list_view_model.dart';

sealed class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object?> get props => [];
}

class ShoppingListsRequested extends ShoppingListEvent {
  const ShoppingListsRequested();
}

class ShoppingListCreated extends ShoppingListEvent {
  const ShoppingListCreated(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}
