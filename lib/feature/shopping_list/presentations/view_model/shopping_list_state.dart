part of 'shopping_list_view_model.dart';

class ShoppingListState extends Equatable {
  const ShoppingListState({
    this.status = ViewModelStatus.initial,
    this.shoppingLists = const [],
    this.selectedShoppingList,
    this.selectedShoppingListItem,
    this.error,
  });

  final ViewModelStatus status;
  final List<ShoppingListOutput> shoppingLists;
  final ShoppingListOutput? selectedShoppingList;
  final ShoppingListItem? selectedShoppingListItem;
  final Exception? error;

  ShoppingListState copyWith({
    ViewModelStatus? status,
    List<ShoppingListOutput>? shoppingLists,
    ShoppingListOutput? selectedShoppingList,
    ShoppingListItem? selectedShoppingListItem,
    Exception? error,
  }) {
    return ShoppingListState(
      status: status ?? this.status,
      shoppingLists: shoppingLists ?? this.shoppingLists,
      selectedShoppingList: selectedShoppingList ?? this.selectedShoppingList,
      selectedShoppingListItem:
          selectedShoppingListItem ?? this.selectedShoppingListItem,
      error: error ?? this.error,
    );
  }

  bool get isInitialLoading =>
      status == ViewModelStatus.initial ||
      (status == ViewModelStatus.loading && shoppingLists.isEmpty);

  bool get isFetchingShoppingList =>
      status == ViewModelStatus.loading && selectedShoppingList == null;

  bool get isFetchingShoppingListItem =>
      status == ViewModelStatus.loading && selectedShoppingListItem == null;

  @override
  List<Object?> get props => [
        status,
        shoppingLists,
        selectedShoppingList,
        selectedShoppingListItem,
        error,
      ];
}
