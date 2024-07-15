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
  const ShoppingListCreated({required this.name, required this.budget});

  final String name;
  final String budget;

  @override
  List<Object?> get props => [name];
}

class ShoppingListDeleted extends ShoppingListEvent {
  const ShoppingListDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
